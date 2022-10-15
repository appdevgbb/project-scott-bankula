resource "azurerm_resource_group" "default" {
    name = "${local.name}-rg"
    location = var.location
}