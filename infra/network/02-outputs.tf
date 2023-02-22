output "vnet" {
  value = azurerm_virtual_network.default
}

output "subnets" {
  value = {
    for k, v in azurerm_subnet[*] : k => v.id
  }
}

output "firewall" {
    value = azurerm_firewall.canadacentral
}

output "private_dns_zones_ids" {
  value = {
    aks = azurerm_private_dns_zone.aks.id
  }
}