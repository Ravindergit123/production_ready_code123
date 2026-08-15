locals {
  tags = merge(
    var.tags,
    {
      ManagedBy   = "Terraform"
      Module      = "storage_account"
      Environment = var.environment
    }
  )
}
