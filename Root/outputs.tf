output "resource_groups" {
  description = "Output summary of resource groups"
  value       = module.rg_name.resource_group_names
}

output "storage_account_ids" {
  description = "Output summary of storage account IDs"
  value       = module.ravistg.storage_account_ids
}

output "virtual_network_ids" {
  description = "Output summary of virtual network IDs"
  value       = module.ravi_vnet.virtual_network_ids
}

output "subnet_ids" {
  description = "Output summary of subnet IDs"
  value       = module.rg_subnet.subnet_ids
}

output "network_interface_ids" {
  description = "Output summary of NIC IDs"
  value       = module.rg_nic.network_interface_ids
}

output "virtual_machine_ids" {
  description = "Output summary of VM IDs"
  value       = module.rgtcsvm.virtual_machine_ids
}
