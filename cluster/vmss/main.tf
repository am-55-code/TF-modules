// Providers
terraform {
    required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
    }
  }
}
// RG Data
data "azurerm_resource_group" "tf-rg" {
  name = "${var.rg_name}-rg"
  
}

// Key-Vault Fetch Info
data "azurerm_key_vault" "kv" {
  name                = "${var.cluster_name}-kv"
  resource_group_name = data.azurerm_resource_group.tf-rg
}
data "azurerm_key_vault_secret" "admin-secret" {
  name         = "admin-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}
# VMSS Parameters
resource "azurerm_linux_virtual_machine_scale_set" "tf-vmss" {
 name                            = "${var.cluster_name}-vmss"
  resource_group_name             = data.azurerm_resource_group.tf-rg
  location                        = data.azurerm_resource_group.tf-rg.location
  sku                             = var.cluster_sku
  instances                       = var.instance_count
  tags                            = var.custom_tags
  admin_username                  = var.username
  disable_password_authentication = false
  admin_password                  = data.azurerm_key_vault_secret.admin-secret.value
  #user_data                       = base64encode(templatefile("${path.module}/userdata.tftpl", local.data_inputs))
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  os_disk {
    storage_account_type = var.os_disk_replication
    caching              = "ReadWrite"
  }
  network_interface {
    name    = "${var.cluster_name}-nic01"
    primary = true
    ip_configuration {
      name                                   = "${var.cluster_name}-ip"
      primary                                = true
      subnet_id                              = data.azurerm_subnet.tf-subnet.id
      load_balancer_backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.beap.backend_ip_configurations.*.id]

    }
  }
}