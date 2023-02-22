resource "azurerm_api_management" "team_a" {
  name                = "${local.name}-apim"
  location            = azurerm_resource_group.team_a.location
  resource_group_name = azurerm_resource_group.team_a.name
  publisher_name      = var.company_name
  publisher_email     = var.admin_email

  sku_name = "Developer_1"

  protocols {
    enable_http2 = true
  }

  virtual_network_type = "External"
  
  virtual_network_configuration {
    subnet_id = azurerm_subnet.apim.id  
  }
}

resource "azurerm_network_security_group" "apim" {
  name = "${local.name}-apim-nsg"
  location = azurerm_resource_group.team_a.location
  resource_group_name = azurerm_resource_group.team_a.name
}

resource "azurerm_network_security_rule" "http" {
  resource_group_name = azurerm_resource_group.team_a.name
  network_security_group_name = azurerm_network_security_group.apim.name

  name = "allowHttpIn"
  priority = 100
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  source_address_prefix = "Internet"
  destination_port_range = "80"
  destination_address_prefix = "VirtualNetwork"
  protocol = "Tcp"
}

resource "azurerm_network_security_rule" "https" {
  resource_group_name = azurerm_resource_group.team_a.name
  network_security_group_name = azurerm_network_security_group.apim.name

  name = "allowHttpsIn"
  priority = 110
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  source_address_prefix = "Internet"
  destination_port_range = "443"
  destination_address_prefix = "VirtualNetwork"
  protocol = "Tcp"
}

resource "azurerm_network_security_rule" "mgmt" {
  resource_group_name = azurerm_resource_group.team_a.name
  network_security_group_name = azurerm_network_security_group.apim.name

  name = "allowApimMgmtIn"
  priority = 200
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  source_address_prefix = "ApiManagement"
  destination_port_range = "3443"
  destination_address_prefix = "VirtualNetwork"
  protocol = "Tcp"
}

resource "azurerm_network_security_rule" "alb" {
  resource_group_name = azurerm_resource_group.team_a.name
  network_security_group_name = azurerm_network_security_group.apim.name

  name = "allowAlbIn"
  priority = 300
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  source_address_prefix = "AzureLoadBalancer"
  destination_port_range = "6390"
  destination_address_prefix = "VirtualNetwork"
  protocol = "Tcp"
}

resource "azurerm_network_security_rule" "storage" {
  resource_group_name = azurerm_resource_group.team_a.name
  network_security_group_name = azurerm_network_security_group.apim.name

  name = "allowStorageOut"
  priority = 100
  direction = "Outbound"
  access = "Allow"
  source_port_range = "*"
  source_address_prefix = "VirtualNetwork"
  destination_port_range = "443"
  destination_address_prefix = "Storage"
  protocol = "Tcp"
}

resource "azurerm_network_security_rule" "sql" {
  resource_group_name = azurerm_resource_group.team_a.name
  network_security_group_name = azurerm_network_security_group.apim.name

  name = "allowSqlOut"
  priority = 200
  direction = "Outbound"
  access = "Allow"
  source_port_range = "*"
  source_address_prefix = "VirtualNetwork"
  destination_port_range = "1433"
  destination_address_prefix = "SQL"
  protocol = "Tcp"
}

resource "azurerm_network_security_rule" "akv" {
  resource_group_name = azurerm_resource_group.team_a.name
  network_security_group_name = azurerm_network_security_group.apim.name

  name = "allowAkvOut"
  priority = 300
  direction = "Outbound"
  access = "Allow"
  source_port_range = "*"
  source_address_prefix = "VirtualNetwork"
  destination_port_range = "443"
  destination_address_prefix = "AzureKeyVault"
  protocol = "Tcp"
}

resource "azurerm_subnet_network_security_group_association" "apim" {
  subnet_id = azurerm_subnet.apim.id
  network_security_group_id = azurerm_network_security_group.apim.id
}