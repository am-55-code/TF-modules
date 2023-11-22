locals {
  http_port = 80
  ssh_port = 22
}


resource "azurerm_public_ip" "lb-pip" {
  name                = "${var.cluster_name}-lb-pip"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  allocation_method   = "Static"
}

resource "azurerm_lb" "tf-lb" {
  name                = "${var.cluster_name}-lb"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name

  frontend_ip_configuration {
    name                 = "${var.cluster_name}-fe-pip"
    public_ip_address_id = azurerm_public_ip.lb-pip.id

  }
}

resource "azurerm_lb_backend_address_pool" "lb-backend" {
  loadbalancer_id = azurerm_lb.tf-lb.id
  name            = "app-vms"
}

resource "azurerm_lb_rule" "tf-lb-rules" {
  loadbalancer_id                = azurerm_lb.tf-lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = local.http_port
  backend_port                   = local.http_port
  frontend_ip_configuration_name = "${var.cluster_name}-fe-pip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb-backend.id]
}

resource "azurerm_lb_rule" "tf-lb-rules" {
  loadbalancer_id                = azurerm_lb.tf-lb.id
  name                           = "SSH-Inbound"
  protocol                       = "Tcp"
  frontend_port                  = local.ssh_port
  backend_port                   = local.ssh_port
  frontend_ip_configuration_name = "${var.cluster_name}-fe-pip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb-backend.id]
}