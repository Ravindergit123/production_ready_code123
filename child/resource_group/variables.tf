variable "rg_name" {
  description = "Map of resource groups to create where key is resource group name and value is location"
  type        = map(string)
}

variable "environment" {
  description = "Target deployment environment (e.g. dev, prod, staging)"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Additional tags to apply to resource groups"
  type        = map(string)
  default     = {}
}
