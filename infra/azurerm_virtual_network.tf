resource "azurerm_virtual_network" "default" {
  name = "${local.name}-vnet"
  location = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  address_space = [
    var.address_space
  ]
}

resource "azurerm_subnet" "apim" {
  name = "ApimSubnet"
  resource_group_name = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes = [
    cidrsubnet(azurerm_virtual_network.default.address_space[0], 8, 2)
  ]
}