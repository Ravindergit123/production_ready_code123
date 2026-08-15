locals {
  tags = merge(
    var.tags,
    {
      ManagedBy   = "Terraform"
      Module      = "nic"
      Environment = var.environment
    }
  )
}
