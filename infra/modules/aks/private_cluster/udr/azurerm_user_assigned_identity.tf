resource "azurerm_user_assigned_identity" "cluster_identity" {
  name                = "${local.name}-cluster-identity"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}

resource "azurerm_user_assigned_identity" "kubelet_identity" {
  name                = "${local.name}-kubelet-identity"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}