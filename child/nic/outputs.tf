output "network_interfaces" {
  description = "Map of created network interface objects"
  value       = azurerm_network_interface.rg_nic
}

output "network_interface_ids" {
  description = "Map of network interface IDs"
  value       = { for k, v in azurerm_network_interface.rg_nic : k => v.id }
}

output "public_ip_addresses" {
  description = "Map of public IP addresses"
  value       = { for k, v in azurerm_public_ip.rg_pip : k => v.ip_address }
}
