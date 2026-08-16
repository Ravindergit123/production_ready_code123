rg_name = {
  "ravi-prod" = "eastus"
}

ravistg = {
  "sa-prod" = {
    name                     = "ravistgproda"
    resource_group_name      = "ravi-prod"
    location                 = "eastus"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }
}

ravivnet = {
  "vnet-prod" = {
    name                = "ravivnetproda"
    location            = "eastus"
    resource_group_name = "ravi-prod"
  }
}

rg_subnet = {
  "rg_subnet1" = {
    name                 = "subnetprod1"
    resource_group_name  = "ravi-prod"
    virtual_network_name = "ravivnetproda"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

rg_nic = {
  "rg_nic1" = {
    name                 = "nicprod1"
    location             = "eastus"
    resource_group_name  = "ravi-prod"
    virtual_network_name = "ravivnetproda"
    subnet_name          = "subnetprod1"
    rg_ipnic             = "ipconfig1"
  }
}

rgtcsvm = {
  "vm1" = {
    name                = "vmprod1"
    resource_group_name = "ravi-prod"
    location            = "eastus"
    nic_name            = "nicprod1"
    admin_username      = "adminuser"
    admin_password      = "HardC0rdeD!"
  }
}
