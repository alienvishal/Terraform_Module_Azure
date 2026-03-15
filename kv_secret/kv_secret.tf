resource "azurerm_key_vault_secret" "kv_secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = var.key_vault_id

  content_type = var.content_type
  tags         = var.tags
}