variable "rg_nic" {
  description = "Map of NIC objects to create"
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    virtual_network_name = string
    subnet_name          = string
    rg_ipnic             = string
  }))
}

variable "environment" {
  description = "Target deployment environment"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Additional tags to apply to NICs"
  type        = map(string)
  default     = {}
}
