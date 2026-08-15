terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.76.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "b4ae5a45-b36d-445c-99a5-c39ef04e44dc"
}
