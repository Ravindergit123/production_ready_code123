output "resource_groups" {
  description = "Map of created resource group objects"
  value       = azurerm_resource_group.ravi
}

output "resource_group_names" {
  description = "Map of resource group names to locations"
  value       = { for k, v in azurerm_resource_group.ravi : k => v.name }
}
