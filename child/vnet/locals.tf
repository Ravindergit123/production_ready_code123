locals {
  tags = merge(
    var.tags,
    {
      ManagedBy   = "Terraform"
      Module      = "vnet"
      Environment = var.environment
    }
  )
}
