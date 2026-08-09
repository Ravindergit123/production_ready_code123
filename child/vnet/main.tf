resource "azurerm_virtual_network" "ravi_vnet" {
  for_each            = var.ravivnet
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = var.address_space
  tags                = local.tags
}