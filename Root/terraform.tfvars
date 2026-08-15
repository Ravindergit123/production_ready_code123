rg_name = {
  "ravi1" = "eastus"
}
<<<<<<< HEAD
=======

ravistg = {
  "sa1" = {
    name                     = "ravistga"
    resource_group_name      = "ravi1"
    location                 = "eastus"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }
}

ravivnet = {
  "ra1" = {
    name                = "ravivneta"
    location            = "eastus"
    resource_group_name = "ravi1"
  }
}

rg_subnet = {
  "rg_subnet1" = {
    name                 = "subnetname1"
    resource_group_name  = "ravi1"
    virtual_network_name = "ravivneta"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

rg_nic = {
  "rg_nic1" = {
    name                 = "nicname1"
    location             = "eastus"
    resource_group_name  = "ravi1"
    virtual_network_name = "ravivneta"
    subnet_name          = "subnetname1"
    rg_ipnic             = "ipconfig1"
  }
}

rgtcsvm = {
  "vm1" = {
    name                = "vm1"
    resource_group_name = "ravi1"
    location            = "eastus"
    nic_name            = "nicname1"
    admin_username      = "adminuser"
    admin_password      = "HardC0rdeD!"
  }
}
>>>>>>> f3f32f1b272315d3f4122b77ff0514918b26a10b
