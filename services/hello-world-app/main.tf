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

module "vmss-networking" {
  source = "git@github.com:am-55-code/TF-modules.git//cluster/networking/vmss?ref=38e60b9"

  rg_name = "hello-world-${var.environment}"
  region = var.region
  cluster_name = "hello-world-${var.environment}"
}

module "keyvault" {
    source = "git@github.com:am-55-code/TF-modules.git//services/key-vault?ref=v0.6.4"
    
    kv_name = "hello-world-kv${var.environment}"
}

module "vmss-cluster" {
    source = "git@github.com:am-55-code/TF-modules.git//cluster/vmss?ref=38e60b9"

    cluster_name = "hello-world-${var.environment}"
    sku = var.sku
    tags = var.custom_tags
     user_data     = templatefile("${path.module}/userdata.sh", {
        server_text = var.server_text
})
}