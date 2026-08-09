output "subnets" {
  description = "Map of created subnet objects"
  value       = azurerm_subnet.rg_subnet
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = { for k, v in azurerm_subnet.rg_subnet : k => v.id }
}
