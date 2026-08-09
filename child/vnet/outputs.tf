output "virtual_networks" {
  description = "Map of created virtual network objects"
  value       = azurerm_virtual_network.ravi_vnet
}

output "virtual_network_ids" {
  description = "Map of virtual network IDs"
  value       = { for k, v in azurerm_virtual_network.ravi_vnet : k => v.id }
}
