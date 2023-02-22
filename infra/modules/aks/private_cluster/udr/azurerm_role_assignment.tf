# Needed for:
# Private Clusters (DNS Zone record required)
resource "azurerm_role_assignment" "cluster_identity_private_dns_zone_contributor" {
  scope                = var.private_dns_zone_id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster_identity.principal_id
}

# Needed for:
# VNET Integrated API Server
resource "azurerm_role_assignment" "api_server_subnet" {
  scope                = var.api_server_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster_identity.principal_id
}

# Needed for:
# VNET Integrated API Server
resource "azurerm_role_assignment" "worker_subnet" {
  scope                = var.worker_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster_identity.principal_id
}