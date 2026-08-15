rg_name = {
  "ravi-pre" = "eastus"
}

ravistg = {
  "sa-pre" = {
    name                     = "ravistgpre"
    resource_group_name      = "ravi-pre"
    location                 = "eastus"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }
}

ravivnet = {
  "vnet-pre" = {
    name                = "vnetpre"
    location            = "eastus"
    resource_group_name = "ravi-pre"
  }
}

rg_subnet = {
  "subnet-pre" = {
    name                 = "subnetpre"
    resource_group_name  = "ravi-pre"
    virtual_network_name = "vnetpre"
    address_prefixes     = ["10.1.2.0/24"]
  }
}

rg_nic = {
  "nic-pre" = {
    name                 = "nicpre"
    location             = "eastus"
    resource_group_name  = "ravi-pre"
    virtual_network_name = "vnetpre"
    subnet_name          = "subnetpre"
    rg_ipnic             = "ipconfigpre"
  }
}

rgtcsvm = {
  "vm-pre" = {
    name                = "vm-pre"
    resource_group_name = "ravi-pre"
    location            = "eastus"
    nic_name            = "nicpre"
    admin_username      = "adminuser"
    admin_password      = "HardC0rdeD!"
  }
}
