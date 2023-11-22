// Providers

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}
locals {
  data_inputs = {
    heading_one = var.heading
  }

  vnet_cidr   = ["10.0.0.0/16"]
  subnet_cidr = ["10.0.2.0/24"]
}



// RG Parameters
resource "azurerm_resource_group" "tf-rg" {
  name     = "${var.cluster_name}-rg"
  location = var.region
}

// Vnet Parameters
resource "azurerm_virtual_network" "tf-vnet" {
  name                = "${var.cluster_name}-vnet"
  address_space       = local.vnet_cidr
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name
}

// Subnet under Vnet Parameters
resource "azurerm_subnet" "tf-subnet" {
  name                 = "${var.cluster_name}-subnet"
  resource_group_name  = azurerm_resource_group.tf-rg.name
  virtual_network_name = azurerm_virtual_network.tf-vnet.name
  address_prefixes     = local.subnet_cidr
}

// Key-Vault Fetch Info
data "azurerm_key_vault" "kv" {
  name                = "${var.cluster_name}-kv"
  resource_group_name = azurerm_resource_group.tf-rg.name
}
data "azurerm_key_vault_secret" "admin-secret" {
  name         = "admin-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

output "webserver_address" {
  value = azurerm_public_ip.lb-pip.ip_address
}

# VMSS Parameters
resource "azurerm_linux_virtual_machine_scale_set" "tf-vmss" {
  name                            = "${var.cluster_name}-vmss"
  resource_group_name             = azurerm_resource_group.tf-rg.name
  location                        = azurerm_resource_group.tf-rg.location
  sku                             = var.cluster_sku
  instances                       = var.instance_count
  tags                            = var.custom_tags
  admin_username                  = var.username
  disable_password_authentication = false
  admin_password                  = data.azurerm_key_vault_secret.admin-secret.value
  user_data                       = base64encode(templatefile("${path.module}/userdata.tftpl", local.data_inputs))

  //  admin_ssh_key {
  //    username   = "am55"
  //   public_key = file("${path.module}/vm.pub")
  //  }

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
      subnet_id                              = azurerm_subnet.tf-subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb-backend.id]

    }
  }
}