resource "azurerm_network_security_group" "default" {
  name                = "${prefix}-azdo-nsg"
  location            = var.azurerm_resource_group.location
  resource_group_name = var.azurerm_resource_group.name
}

resource "azurerm_network_security_rule" "default" {
  name                        = "https"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.azurerm_resource_group.name
  network_security_group_name = azurerm_network_security_group.default.name
}