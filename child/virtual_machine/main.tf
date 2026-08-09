resource "azurerm_linux_virtual_machine" "rgtcsvm" {
  for_each                        = var.rgtcsvm
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = try(each.value.size, "Standard_DC1s_v3")
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  tags                            = local.tags

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive

    # Wait for background dpkg/apt locks to release
    while fuser /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/lib/apt/lists/lock >/dev/null 2>&1; do
        sleep 3
    done

    # Install Node.js 22, Nginx, Docker, Git, Curl
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
    apt-get update -y
    apt-get install -y nodejs nginx docker.io docker-compose git curl jq

    systemctl enable docker || true
    systemctl start docker || true
    systemctl enable nginx || true
    systemctl start nginx || true

    # 1. Build and Deploy Axion Dashboard React Application (axion-ui) on Nginx Port 80
    mkdir -p /tmp/axion-ui
    git clone https://github.com/devopsinsiders/axion-ui.git /tmp/axion-ui || true
    cd /tmp/axion-ui
    npm install || true
    npx vite build || npm run build || true
    rm -rf /var/www/html/*
    cp -r dist/* /var/www/html/ 2>/dev/null || cp -r build/* /var/www/html/ 2>/dev/null || cp -r /tmp/axion-ui/* /var/www/html/
    systemctl restart nginx || true

    # 2. Prepare Axion Microservices + PostgreSQL + pgAdmin Suite
    mkdir -p /opt/axion
    cd /opt/axion

    git clone https://github.com/devopsinsiders/axion-database-schema.git || true
    git clone https://github.com/devopsinsiders/axion-ingestion-service.git || true
    git clone https://github.com/devopsinsiders/axion-telemetry-query-service.git || true
    git clone https://github.com/devopsinsiders/axion-data-simulator.git || true

    mkdir -p /opt/axion/db-init
    if [ -d "/opt/axion/axion-database-schema" ]; then
      cp /opt/axion/axion-database-schema/*.sql /opt/axion/db-init/ 2>/dev/null || true
    fi

    cat << 'DOCKERCOMPOSE' > /opt/axion/docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: axion-postgres
    restart: always
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgrespassword
      POSTGRES_DB: telemetry_db
    ports:
      - "5432:5432"
    volumes:
      - ./db-init:/docker-entrypoint-initdb.d

  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: axion-pgadmin
    restart: always
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@admin.com
      PGADMIN_DEFAULT_PASSWORD: adminpassword
      PGADMIN_LISTEN_PORT: 5050
    ports:
      - "5050:5050"
    depends_on:
      - postgres

  ingestion-service:
    build:
      context: ./axion-ingestion-service
      dockerfile: Dockerfile
    container_name: axion-ingestion-service
    restart: always
    environment:
      DATABASE_URL: postgresql://postgres:postgrespassword@postgres:5432/telemetry_db
    ports:
      - "5000:5000"
    depends_on:
      - postgres

  query-service:
    build:
      context: ./axion-telemetry-query-service
      dockerfile: Dockerfile
    container_name: axion-query-service
    restart: always
    environment:
      DATABASE_URL: postgresql://postgres:postgrespassword@postgres:5432/telemetry_db
    ports:
      - "8000:8000"
    depends_on:
      - postgres

  data-simulator:
    build:
      context: ./axion-data-simulator
      dockerfile: Dockerfile
    container_name: axion-data-simulator
    restart: always
    environment:
      INGESTION_SERVICE_URL: http://ingestion-service:5000/telemetry
    depends_on:
      - ingestion-service
DOCKERCOMPOSE

    for repo in axion-ingestion-service axion-telemetry-query-service axion-data-simulator; do
      if [ -d "/opt/axion/$repo" ] && [ ! -f "/opt/axion/$repo/Dockerfile" ]; then
        cat << 'PYDOCKER' > /opt/axion/$repo/Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY . /app
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi
EXPOSE 5000 8000
CMD ["python", "main.py"]
PYDOCKER
      fi
    done

    cd /opt/axion
    docker-compose up -d --build || true
  EOF
  )

  network_interface_ids = [
    try(var.network_interface_ids[replace(each.key, "vm", "rg_nic")], var.network_interface_ids[each.key])
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
