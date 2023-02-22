module "aks" {
    source = "../modules/aks/private_cluster/outbound-type/egress-lockdown"

    resource_group = azurerm_resource_group.team_a
    outbound_type = "userDefinedRouting"
    
    api_server_subnet_id = var.api_server_subnet_id
    cluster_subnet_id = var.cluster_subnet_id

}