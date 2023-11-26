variable "cluster_name" {
  description = "Name for the cluster"
  type        = string
  default     = "tf-webcluster"
}

variable "rg_name" {
  description = "Name for the resource group"
  type        = string
  default     = "app-webcluster"
}

variable "cluster_sku" {
  description = "SKU Family for the cluster"
  type        = string
  default     = "Standard_B1s"
}

variable "instance_count" {
  description = "Number of replicas in the cluster"
  type        = number
  default     = 1
}

variable "custom_tags" {
  description = "Custom tags for instances in the VMSS"
  type        = map(string)
  default = {
    "name" = "value"
  }
}

variable "username" {
  description = "Username for the cluster"
  type        = string
  default = "am55"
  sensitive   = true
}

variable "os_disk_replication" {
  description = "Replication for the OS disk"
  type        = string
  default     = "Standard_LRS"
}
