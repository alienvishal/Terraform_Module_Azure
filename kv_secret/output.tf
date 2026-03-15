output "secret_id" {
  description = "The ID of the Key Vault secret"
  value       = azurerm_key_vault_secret.kv_secret.id
}

output "secret_name" {
  description = "The name of the secret"
  value       = azurerm_key_vault_secret.kv_secret.name
}