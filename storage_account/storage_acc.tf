resource "azurerm_storage_account" "stg" {

  name                     = var.name
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind

  lifecycle {
    precondition {
      condition     = local.is_valid_tier_for_kind
      error_message = "If account_tier is 'Premium', then account_kind must be either 'BlockBlobStorage' or 'FileStorage'."
    }
  }
  tags = merge(
    {
      Owner         = var.product_owner,
      Department    = var.department
      "Cost Center" = var.cost_center
      ProjectName   = var.project_name,
      deployment    = "terraform"
    },
    var.tags
  )
}

resource "azurerm_storage_container" "account_blob" {
  for_each = { for blob in var.blob: blob.name => blob }
  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.stg.id
  container_access_type = each.value.container_access_type
}

resource "azurerm_storage_queue" "account_queue" {
  for_each = { for queue in var.queue: queue.name => queue }
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.stg.name
}

resource "azurerm_storage_table" "account_table" {
  for_each = { for table in var.table: table.name => table }
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.stg.name

}