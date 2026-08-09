rg_name = {
  "ravi1" = "westus"
  "ravi2" = "eastus"
}

ravistg = {
  "sa1" = {
    name                     = "ravistga"
    resource_group_name      = "ravi1"
    location                 = "westus"
    account_replication_type = "GRS"
    account_tier             = "Standard"
  }
  "sa2" = {
    name                     = "ravistgb"
    resource_group_name      = "ravi2"
    location                 = "eastus"
    account_replication_type = "GRS"
    account_tier             = "Standard"
  }
}

ravivnet = {
  "ra1" = {
    name                = "ravivneta"
    location            = "westus"
    resource_group_name = "ravi1"
  }
  "ra2" = {
    name                = "ravivnetb"
    location            = "eastus"
    resource_group_name = "ravi2"
  }
}

rg_subnet = {
  "rg_subnet1" = {
    name                 = "subnetname1"
    resource_group_name  = "ravi1"
    virtual_network_name = "ravivneta"
    address_prefixes     = ["10.0.2.0/24"]
  }
  "rg_subnet2" = {
    name                 = "subnetname2"
    resource_group_name  = "ravi2"
    virtual_network_name = "ravivnetb"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

rg_nic = {
  "rg_nic1" = {
    name                 = "nicname1"
    location             = "westus"
    resource_group_name  = "ravi1"
    virtual_network_name = "ravivneta"
    subnet_name          = "subnetname1"
    rg_ipnic             = "ipconfig1"
  }
  "rg_nic2" = {
    name                 = "nicname2"
    location             = "eastus"
    resource_group_name  = "ravi2"
    virtual_network_name = "ravivnetb"
    subnet_name          = "subnetname2"
    rg_ipnic             = "ipconfig2"
  }
}

rgtcsvm = {
  "vm1" = {
    name                = "vm1"
    resource_group_name = "ravi1"
    location            = "westus"
    nic_name            = "nicname1"
    admin_username      = "adminuser"
    admin_password      = "HardC0rdeD!"
  }
  "vm2" = {
    name                = "vm2"
    resource_group_name = "ravi2"
    location            = "eastus"
    nic_name            = "nicname2"
    admin_username      = "adminuser"
    admin_password      = "HardC0rdeD!"
  }
}
