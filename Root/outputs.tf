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

output "public_ip_addresses" {
  description = "Public IP addresses assigned to virtual machines"
  value       = module.rg_nic.public_ip_addresses
}

output "axion_ui_web_urls" {
  description = "Axion UI Frontend Web Application URLs"
  value       = { for k, v in module.rg_nic.public_ip_addresses : k => "http://${v}" }
}

output "axion_ingestion_api_urls" {
  description = "Axion Ingestion Service API Endpoints"
  value       = { for k, v in module.rg_nic.public_ip_addresses : k => "http://${v}:5000" }
}

output "axion_query_api_urls" {
  description = "Axion Telemetry Query Service API Endpoints"
  value       = { for k, v in module.rg_nic.public_ip_addresses : k => "http://${v}:8000" }
}

output "pgadmin_web_urls" {
  description = "pgAdmin 4 Web Interface URLs for PostgreSQL DB Management"
  value       = { for k, v in module.rg_nic.public_ip_addresses : k => "http://${v}:5050" }
}

output "virtual_machine_ids" {
  description = "Output summary of VM IDs"
  value       = module.rgtcsvm.virtual_machine_ids
}
