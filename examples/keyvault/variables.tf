variable "kv" {
  type    = string
  default = "-kv"

}

variable "rg_name" {
  description = "Name for the resource group"
  default = null

}

variable "region" {
  description = "Region for the resource group"
  type = string
  default = "eastus"
}

variable "kv_name" {
  type    = string
  default = "Vault-AM55"
}

variable "service-principal" {
  type    = string
  default = "Terraform-SP-Staging"
}

variable "ga-object-id" {
  type    = string
  default = "c427f6f0-4162-4061-9cb0-b1a4ec82035d"
}

variable retention_days {
  type = number
  description = "Retention days for vault/secrets after deletion"
  default = 7
}

variable "secret" {
  type = map(any)
  default = {
    name      = "admin-secret"
    value     = "P@ssW0rd!"
    sensitive = true
  }

}