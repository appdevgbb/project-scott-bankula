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

resource "azurerm_subnet" "aks_api" {
  name = "AksApiSubnet"
  resource_group_name = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  delegation {
    name = "Aks"
    service_delegation {
      name = "Microsoft.ContainerService/managedClusters"
    }
  }
  address_prefixes = [
    cidrsubnet(cidrsubnet(azurerm_virtual_network.default.address_space[0], 8, 3), 4, 0)
  ]
}

resource "azurerm_subnet" "aks_worker" {
  name = "AksWorkerSubnet"
  resource_group_name = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes = [
    cidrsubnet(azurerm_virtual_network.default.address_space[0], 8, 4)
  ]
}