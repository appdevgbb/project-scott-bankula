output "id" {
  value = azurerm_kubernetes_cluster.default.id
}

output "cluster_identity" {
  value = azurerm_user_assigned_identity.cluster_identity.id
}

output "kubelet_identity" {
    value = azurerm_user_assigned_identity.kubelet_identity.id
}