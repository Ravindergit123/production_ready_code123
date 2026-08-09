locals {
  tags = merge(
    var.tags,
    {
      ManagedBy   = "Terraform"
      Module      = "resource_group"
      Environment = var.environment
    }
  )
}
