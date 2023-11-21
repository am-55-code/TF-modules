// Providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.46.0"
    }
  }

    required_version = ">= 1.1.0"
  }

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.cluster_name}-rg"
  location = var.rg.region
}

data "azuread_service_principal" "tf-sp" {
  display_name = var.service-principal

}

resource "azurerm_key_vault" "kv" {
  name                = "${var.cluster_name}-kv"
  location            = var.rg.region
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id           = var.tenant

  access_policy {
    tenant_id = var.tenant
    object_id = data.azuread_service_principal.tf-sp.object_id

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Purge", "Recover"
    ]
  }
}
resource "azurerm_key_vault_secret" "admin-secret" {
  name         = var.secret.name
  value        = var.secret.value
  key_vault_id = azurerm_key_vault.kv.id
}

