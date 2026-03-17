resource "azurerm_service_plan" "asp" {
  name                       = var.name
  resource_group_name        = var.rg_name
  location                   = var.rg_location
  os_type                    = var.os_type
  sku_name                   = var.sku_name
  app_service_environment_id = var.ase_id

  tags = var.tags
}