variable "heading" {
  description = "heading title for index.html"
  default     = "Hello World!"
  type        = string
  sensitive   = false

}

variable "region" {
  description = "Region for cluster"
  type = string
  default = "East US"
  
}

variable "cluster_name" {
  description = "Name for the cluster"
  type = string
  default = "tf-webcluster"

}

variable "cluster_sku" {
  description = "SKU Family for the cluster"
  type = string
  default = "Standard_B1s"
}

variable "instance_count" {
  description = "Number of replicas in the cluster"
  type = number
  default = 1
    
}

variable "os_disk_replication" {
  description = "Replication for the OS disk"
  type = string
  default = "Standard_LRS"
}

variable "storage_account_name" {
  description = "Name for State file STG"
  type = string
  default = "tfstg055654770390"
  
}

variable "storage_container_name" {
  description = "Container name for the state file"
  type = string
  
}

variable "state_file_remote_key" {
  description = "Key Name for the state file"
  type = string
}

variable "server_http" {
  description = "Port for HTTP to the internet"
  default     = 80
  type        = number


}
