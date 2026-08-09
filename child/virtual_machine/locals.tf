locals {
  tags = merge(
    var.tags,
    {
      ManagedBy   = "Terraform"
      Module      = "virtual_machine"
      Environment = var.environment
    }
  )
}
