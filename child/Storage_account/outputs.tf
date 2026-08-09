output "storage_accounts" {
  description = "Map of created storage account objects"
  value       = azurerm_storage_account.ravistg
  sensitive   = true
}

output "storage_account_ids" {
  description = "Map of storage account IDs"
  value       = { for k, v in azurerm_storage_account.ravistg : k => v.id }
}
