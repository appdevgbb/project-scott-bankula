resource "azurerm_role_assignment" "cluster-private-dns-zone-contributor" {
  scope                = var.private_dns_zone_id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster_identity.principal_id
}