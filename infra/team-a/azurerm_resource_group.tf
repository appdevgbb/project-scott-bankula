resource azurerm_resource_group team_a {
    name = "${var.prefix}aks"
    location = var.location
}