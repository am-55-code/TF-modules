output "vmss-name" {
    description = "Name for the vmss"
    value = azurerm_linux_virtual_machine_scale_set.tf-vmss.name  
}

output "vmss-sku" {
    description = "SKU for the vmss"
    value = azurerm_linux_virtual_machine_scale_set.tf-vmss.sku 
}

