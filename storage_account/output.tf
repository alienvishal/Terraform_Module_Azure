output "storage_account_connection_string" {
  value = azurerm_storage_account.stg.primary_connection_string
}

output "storage_account_access_key" {
  value = azurerm_storage_account.stg.primary_access_key
}

output "storage_account_name" {
  value = azurerm_storage_account.stg.name
}