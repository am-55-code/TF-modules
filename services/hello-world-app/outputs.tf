output "rg-name" {
  description = "Name for the RG"
  value = module.vmss-networking.rg_name
} 

output "lb-public-ip" {
  description = "The IP Address for the Load Balancer"
  value = module.vmss-networking.lb-pip.ip_address
}

output "kv-name" {
  description = "The name for the Key Vault"
  value = module.keyvault.kv_name
}

output "vmss-name" {
    description = "Name for the vmss"
    value = module.vmss-cluster.name  
}

