output "rg-name" {
  description = "Name for the RG"
  value = azurerm_resource_group.tf-rg.name
} 

output "rg-id" {
  value = azurerm_resource_group.tf-rg.id
}

output "lb-public-ip" {
  description = "The IP Address for the Load Balancer"
  value = azurerm_public_ip.lb-pip.ip_address
}


output "subnet_id" {
  value = azurerm_subnet.tf-subnet.id
}

output "backend_ip_configuration_ids" {
  value = azurerm_lb_backend_address_pool.lb-backend.id
}
