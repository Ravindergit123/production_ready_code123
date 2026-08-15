variable "rg_name" {
  description = "Map of resource groups to create where key is resource group name and value is location"
  type        = map(string)
}
