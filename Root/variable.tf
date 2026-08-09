variable "rg_name" {
    description = "The name of the resource group"
    type        = string
    default     = "ravi-rg"
}

variable "rg_location" {
    description = "The location of the resource group"
    type        = string
    default     = "East US"
}

variable "rg_vnet" {
  description = "value"
  type = string
  default = "tcs_vnet"
}

variable "rg_subnet" {
  description = "value"
  type = string
  default = "rg_subnet"
}
variable "rg_nic" {
    description = "value"
    type = string
    default = "rg_nic"
  
}
variable "rg_ipnic" {
    description = "value"
     type = string
     default = "rg_ipnic"
  
}

variable "rgtcsvm" {
  description = "value"
  type = string
  default = "tcsvm"
}