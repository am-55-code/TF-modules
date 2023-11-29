// Providers
terraform {
   required_version = ">= 1.1.0"
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
}

// RG for KeyVault
data "azurerm_resource_group" "tf-rg" {
  name = "${var.rg_name}-rg"
}

// Fetch data from the Terraform ServicePrincipal
data "azuread_service_principal" "tf-sp" {
  display_name = var.service-principal
}

// Fetch data from the current Az Account (Tenant,AppObjectId,SubId)
data "azurerm_client_config" "current" {
}
// Creating a Key Vault
resource "azurerm_key_vault" "kv" {
  name                       = "${var.kv_name}-kv"
  location                   = data.azurerm_resource_group.tf-rg.location
  resource_group_name        = data.azurerm_resource_group.tf-rg.name
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = var.retention_days
}

// Creating a KeyVault Access Policy (Terraform SP)
resource "azurerm_key_vault_access_policy" "tf-ap-sp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "Set", "List", "Delete", "Purge", "Recover"
  ]
}

// Creating a KeyVault Access Policy (GA User)
resource "azurerm_key_vault_access_policy" "tf-ap-ga" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.ga-object-id

  secret_permissions = [
    "Get", "Set", "List", "Delete", "Purge", "Recover"
  ]
}

// Creating a Secret
resource "azurerm_key_vault_secret" "admin-secret" {
  name         = var.secret.name
  value        = var.secret.value
  key_vault_id = azurerm_key_vault.kv.id
}

