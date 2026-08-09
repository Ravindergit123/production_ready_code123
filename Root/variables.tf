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
