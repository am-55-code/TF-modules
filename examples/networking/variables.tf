variable "environment" {
  type = string
  description = "Environment deployed to:"
  default = "staging"
}

variable "region" {
    type = string
    description = "Resource Group region:"
    default = "eastus"
}