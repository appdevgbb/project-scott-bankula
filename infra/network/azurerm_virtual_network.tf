resource "azurerm_virtual_network" "default" {
  name = "${local.name}-vnet"
  location = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  address_space = [
    var.address_space
  ]
}


# 16 x /28 Cidrs (10.0.0.0-15, 10.0.0.16-31, 10.0.0.32-47, etc)
resource "azurerm_subnet" "firewall" {
  name = "AzureFirewallSubnet"
  resource_group_name = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes = [
    cidrsubnet(azurerm_virtual_network.default.address_space[0], 12, 0)
  ]
}

resource "azurerm_subnet" "apim" {
  name = "ApimSubnet"
  resource_group_name = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes = [
    cidrsubnet(azurerm_virtual_network.default.address_space[0], 12, 1)
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
    cidrsubnet(azurerm_virtual_network.default.address_space[0], 12, 2)
  ]
}

# /24 Cidrs starting from 10.0.4.0
resource "azurerm_subnet" "aks_worker" {
  name = "AksWorkerSubnet"
  resource_group_name = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes = [
    cidrsubnet(azurerm_virtual_network.default.address_space[0], 8, 4)
  ]
}

resource "azurerm_subnet" "azdo" {
  name = "AzdoSubnet"
  resource_group_name = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes = [
    cidrsubnet(azurerm_virtual_network.default.address_space[0], 8, 5)
  ]
}