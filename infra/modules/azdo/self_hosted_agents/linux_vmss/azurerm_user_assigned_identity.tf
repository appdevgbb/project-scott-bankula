resource "azurerm_user_assigned_identity" "azdo_identity" {
  name                = "${local.name}-azdo-identity"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}