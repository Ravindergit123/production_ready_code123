variable "rgtcsvm" {
  description = "Map of virtual machine objects to create"
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

variable "environment" {
  description = "Target deployment environment"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Additional tags to apply to VMs"
  type        = map(string)
  default     = {}
}
