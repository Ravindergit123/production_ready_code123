variable "ravivnet" {
  description = "Map of virtual network objects to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "address_space" {
  description = "Default address space for virtual networks if not specified per vnet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
