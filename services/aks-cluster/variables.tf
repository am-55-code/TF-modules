variable "name" {
  description = "Name for the AKS cluster"
  type = string
}

variable "username" {
  description = "Name Admin User for the cluster"
  type = string
  default = "am55"
  sensitive = true
}

variable "rg_region" {
  description = "Region for the resource group"
  type = string
  default = "eastus"
}

variable "msi_id" {
    type        = string
    description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
    default     = null  
}

variable "min_size" {
  description = "Minimum node number for the cluster"
  type = number
}

variable "max_size" {
  description = "Maximum node number for the cluster"
  type = number
}

variable "desired_size" {
  description = "Desired number of nodes for the cluster"
  type = number
}

variable "vm_size" {
  description = "Size of instance to run in the node "
  type = list(string)
  default = [ "Standard_B1ms" ]
}
