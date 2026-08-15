output "virtual_machines" {
  description = "Map of created virtual machine objects"
  value       = azurerm_linux_virtual_machine.rgtcsvm
  sensitive   = true
}

output "virtual_machine_ids" {
  description = "Map of virtual machine IDs"
  value       = { for k, v in azurerm_linux_virtual_machine.rgtcsvm : k => v.id }
}
