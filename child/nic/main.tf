resource "azurerm_public_ip" "rg_pip" {
  for_each            = var.rg_nic
  name                = "pip-${each.value.name}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_network_security_group" "rg_nsg" {
  for_each            = var.rg_nic
  name                = "nsg-${each.value.name}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = local.tags

  security_rule {
    name                       = "HTTP-UI"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Ingestion-Service"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Query-Service"
    priority                   = 106
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "PostgreSQL"
    priority                   = 107
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "pgAdmin"
    priority                   = 108
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5050"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "rg_nic" {
  for_each            = var.rg_nic
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                          = each.value.rg_ipnic
    subnet_id                     = try(var.subnet_ids[replace(each.key, "rg_nic", "rg_subnet")], var.subnet_ids[each.key])
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.rg_pip[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "rg_nic_nsg_assoc" {
  for_each                  = var.rg_nic
  network_interface_id      = azurerm_network_interface.rg_nic[each.key].id
  network_security_group_id = azurerm_network_security_group.rg_nsg[each.key].id
}