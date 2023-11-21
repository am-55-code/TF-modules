variable "kv" {
  type    = string
  default = "-kv"

}

variable "rg" {
  type = map(any)
  default = {
    region = "East US"
  }

}

variable "cluster_name" {
  type    = string
  default = "Vault"
}

variable "tenant" {
  type    = string
  default = "62f91faf-22cf-40e1-aa66-30dbbcba5355"
}

variable "service-principal" {
  type    = string
  default = "Terraform-SP-Staging"
}

variable "secret" {
  type = map(any)
  default = {
    name      = "admin-secret"
    value     = "P@ssW0rd!"
    sensitive = true
  }

}