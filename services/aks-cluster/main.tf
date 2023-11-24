terraform {
   required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
        }
    random = {
        source = "hashicorp/random"
        version = "~> 3.5.1"
        }
    azapi = {
        source = "Azure/azapi"
        version = "1.10.0"
        }
    }
}

resource "azurerm_resource_group" "aks-rg" {
    name = "${var.name}-rg"
    location = var.rg_region  
}

resource "random_uuid" "aks" {  
}

resource "azurerm_kubernetes_cluster" "aks" {
    name = "${random_uuid.aks.result}-aks"
    location = azurerm_resource_group.aks-rg.location
    resource_group_name = azurerm_resource_group.aks-rg.name
    dns_prefix = "${random_uuid.aks.result}-dns"

    identity {
        type = "SystemAssigned"  
        }

    default_node_pool {
        name = "agentpool"
        vm_size = var.vm_size[0]
        node_count = var.desired_size      
    }
    linux_profile {
      admin_username = var.username

      ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
      }
    }
    network_profile {
      network_plugin = "kubenet"
      load_balancer_sku = "standard"
    }
}