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
    sudo apt-get update -y
    sudo apt-get install -y nginx git
    sudo rm -rf /var/www/html/*
    git clone https://github.com/devopsinsiders/StreamFlix.git /tmp/StreamFlix
    sudo cp -r /tmp/StreamFlix/* /var/www/html/
    sudo systemctl enable nginx
    sudo systemctl restart nginx
  EOF
  )

  network_interface_ids = [
    data.azurerm_network_interface.rg_nic[each.key].id,
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
