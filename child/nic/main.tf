resource "azurerm_network_interface" "rg_nic" {
  for_each            = var.rg_nic
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                          = each.value.rg_ipnic
    subnet_id                     = data.azurerm_subnet.rg_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}