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
    set -e

    # Update and Install Docker, Docker-Compose & Git
    sudo apt-get update -y
    sudo apt-get install -y docker.io docker-compose git curl jq

    sudo systemctl enable docker
    sudo systemctl start docker

    # Prepare Axion Platform Directory
    mkdir -p /opt/axion
    cd /opt/axion

    # Clone all 5 Axion Microservices Repositories
    git clone https://github.com/devopsinsiders/axion-database-schema.git || true
    git clone https://github.com/devopsinsiders/axion-ingestion-service.git || true
    git clone https://github.com/devopsinsiders/axion-telemetry-query-service.git || true
    git clone https://github.com/devopsinsiders/axion-ui.git || true
    git clone https://github.com/devopsinsiders/axion-data-simulator.git || true

    # Prepare Database Init Schema
    mkdir -p /opt/axion/db-init
    if [ -d "/opt/axion/axion-database-schema" ]; then
      cp /opt/axion/axion-database-schema/*.sql /opt/axion/db-init/ 2>/dev/null || true
    fi

    # Create Docker Compose Configuration for full Axion Microservices Suite
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

  ui:
    build:
      context: ./axion-ui
      dockerfile: Dockerfile
    container_name: axion-ui
    restart: always
    ports:
      - "80:80"
    depends_on:
      - query-service

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

    # Fallback Dockerfile generation if missing in cloned source
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

    if [ -d "/opt/axion/axion-ui" ] && [ ! -f "/opt/axion/axion-ui/Dockerfile" ]; then
      cat << 'UIDOCKER' > /opt/axion/axion-ui/Dockerfile
FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
UIDOCKER
    fi

    # Launch Axion Container Stack
    cd /opt/axion
    docker-compose up -d --build || true
  EOF
  )

  network_interface_ids = [
    try(var.network_interface_ids[replace(each.key, "vm", "rg_nic")], try(var.network_interface_ids[each.key], data.azurerm_network_interface.rg_nic[each.key].id))
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
