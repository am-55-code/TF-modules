output "ServicePrincipal" {
  value       = data.azurerm_client_config.current.client_id
  description = "Current SP used: "

}

output "KeyVaultName" {
  value       = azurerm_key_vault.kv.name
  description = "Key Vault name:"
}