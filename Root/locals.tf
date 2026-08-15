locals {
  environment = var.environment
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "Azure-Infra"
    }
  )
}
