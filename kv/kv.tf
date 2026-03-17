resource "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
  location            = var.rg_location

  dynamic "access_policy" {
    for_each = {
      for i, policy in local.access_policy_config : "${policy.object_ids}-${i}" => policy
    }
    content {
      object_id = access_policy.value.object_ids
      tenant_id = data.azurerm_client_config.current.tenant_id

      key_permissions         = access_policy.value.key_permissions
      storage_permissions     = access_policy.value.storage_permissions
      certificate_permissions = access_policy.value.certificate_permissions
      secret_permissions      = access_policy.value.secret_permissions
    }
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
    secret_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
    storage_permissions     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
    certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
  }

  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = var.sku_name
  purge_protection_enabled      = var.is_purge_protection_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
  public_network_access_enabled = var.is_public_network_access_enabled
  tags = var.tags
}