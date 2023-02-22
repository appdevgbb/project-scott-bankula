resource azurerm_private_dns_zone aks {
    name = "privatelink.${var.location}.azmk8s.io"
    resource_group_name = azurerm_resource_group.default.name
}