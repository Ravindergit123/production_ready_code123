variable "environment" {
  description = "Target deployment environment"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Global tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "rg_name" {
  description = "Map of Resource Groups to create"
  type        = map(string)
}

variable "ravistg" {
  description = "Map of Storage Accounts to create"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_replication_type = string
    account_tier             = string
  }))
}

variable "ravivnet" {
  description = "Map of Virtual Networks to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "rg_subnet" {
  description = "Map of Subnets to create"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "rg_nic" {
  description = "Map of Network Interfaces to create"
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    virtual_network_name = string
    subnet_name          = string
    rg_ipnic             = string
  }))
}

variable "rgtcsvm" {
  description = "Map of Virtual Machines to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    nic_name            = string
    admin_username      = string
    admin_password      = string
    size                = optional(string, "Standard_DC1s_v3")
  }))
}
