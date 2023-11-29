terraform {
   required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
    }
  }
backend "azurerm" {
    key                  = "staging-vmss-networking-md.tfstate"
    container_name       = "tfstate"
    storage_account_name = "tfstg055654770390"
  }
}

provider "azurerm" {
  features {}
}

module "vmss-networking" {
  source = "../../cluster/networking/vmss"

  rg_name = "networking-${var.environment}"
  region = var.region
  cluster_name = "networking-${var.environment}"
}
