terraform {
   required_version = ">= 1.1.0"
backend "azurerm" {
    key                  = "keyvault-ex-md.tfstate"
    container_name       = "tfstate"
    storage_account_name = "tfstg055654770390"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    } 
  }
}

provider "azuread" {}

module "KeyVault" {
  source = "../../services/key-vault"

  rg_name = "Key-Vault-RG"
  kv_name = var.kv_name
  retention_days = 7
}