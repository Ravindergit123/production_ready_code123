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
