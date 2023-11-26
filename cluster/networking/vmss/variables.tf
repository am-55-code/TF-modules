variable "rg_name" {
  description = "Name for the resource group"
  type        = string
  default     = "app-webcluster"
}

variable "region" {
  description = "Region for cluster"
  type        = string
  default     = "East US"
}

variable "cluster_name" {
  description = "Name for the resource group"
  type        = string
  default     = "tf-webcluster"
}