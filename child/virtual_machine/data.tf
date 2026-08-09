data "azurerm_network_interface" "rg_nic" {
  for_each            = var.rgtcsvm
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}
