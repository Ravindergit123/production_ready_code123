resource "azurerm_resource_group" "ravi" {
  for_each = var.rg_name
  name     = each.key
  location = each.value
  tags     = local.tags
}

resource "azurerm_resource_group" "ravi" {
  for_each = var.rg_name
  name     = each.key
  location = each.value
  tags     = local.tags
}

resource "azurerm_resource_group" "ravi" {
  for_each = var.rg_name
  name     = each.key
  location = each.value
  tags     = local.tags
}

resource "azurerm_resource_group" "ravi" {
  for_each = var.rg_name
  name     = each.key
  location = each.value
  tags     = local.tags
}

# resource "azurerm_resource_group" "ravi" {
#   for_each = var.rg_name
#   name     = each.key
#   location = each.value
#   tags     = local.tags
# }