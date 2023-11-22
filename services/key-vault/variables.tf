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
variable "secret" {
  type = map(any)
  default = {
    name      = "admin-secret"
    value     = "P@ssW0rd!"
    sensitive = true
  }

}