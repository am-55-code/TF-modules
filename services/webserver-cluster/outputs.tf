output "webserver_address" {
  value       = azurerm_public_ip.lb-pip.ip_address
  description = "The IP address of the load balancer"
}