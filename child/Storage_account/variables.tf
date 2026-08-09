variable "ravistg" {
  description = "Map of storage account objects to create"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
  }))
}

variable "environment" {
  description = "Target deployment environment"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Additional tags to apply to storage accounts"
  type        = map(string)
  default     = {}
}
