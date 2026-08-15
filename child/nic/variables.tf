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

variable "subnet_ids" {
  description = "Map of Subnet IDs passed from rg_subnet module"
  type        = map(string)
  default     = {}
}
