resource "azurerm_kubernetes_cluster" "default" {
  depends_on = [
    azurerm_role_assignment.example,
  ]

  name                    = local.name
  location                = var.resource_group.location
  resource_group_name     = var.resource_group.name
  dns_prefix              = local.name
  private_cluster_enabled = true
  private_dns_zone_id     = var.private_dns_zone_id

  api_server_access_profile = {
    subnet_id = var.api_server_subnet_id
    vnet_integration_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    network_plugin_mode = "Overlay"
    network_policy = "calico"
    outbound_type = var.outbound_type
    pod_cidr = "192.168.0.0/16"
    docker_bridge_cidr = "172.17.0.0/16"
    service_cidr = "172.18.0.0/22"
    dns_service_ip = "172.18.0.5"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
        azurerm_user_assigned_identity.cluster_identity.id
    ]
  }

  kubelet_identity {
    user_assigned_identity_id = azurerm_user_assigned_identity.kubelet_identity.id
  }

	role_based_access_control_enabled =  true
	
	azure_active_directory_role_based_access_control {
		managed = true
		admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled = true
	}
	
  default_node_pool {
    name = "defaultnp01"
    vm_size = "Standard_D4s_v3"
    only_critical_addons_enabled = true
    vnet_subnet_id = var.cluster_subnet_id
  }
}