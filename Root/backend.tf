terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "ravitfstate2026"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "ravitfstate2026"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
