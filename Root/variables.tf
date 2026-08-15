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

variable "ravistg" {
  description = "Map of Storage Accounts"
  type        = any
}

variable "ravivnet" {
  description = "Map of Virtual Networks"
  type        = any
}

variable "rg_subnet" {
  description = "Map of Subnets"
  type        = any
}

variable "rg_nic" {
  description = "Map of Network Interfaces"
  type        = any
}

variable "rgtcsvm" {
  description = "Map of Virtual Machines"
  type        = any
}
