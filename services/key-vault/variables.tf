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

variable "cluster-name" {
  type    = string
  default = "tf-webcluster"
}

variable "tenant" {
  type    = string
  default = "62f91faf-22cf-40e1-aa66-30dbbcba5355"
}

variable "object" {
  type    = string
  default = "7e16f3d5-6211-40bb-b991-c7ce11ebb9cc"
}

variable "secret" {
  type = map(any)
  default = {
    name = "admin-secret"
    value = "P@ssW0rd!"
  }

}