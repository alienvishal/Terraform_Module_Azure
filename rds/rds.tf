resource "azurerm_redis_cache" "rds" {
  name                 = var.rds_name
  resource_group_name  = var.rg_name
  location             = var.rg_location
  family               = var.rds_faimly
  capacity             = var.rds_capacity
  sku_name             = var.rds_sku
  minimum_tls_version  = 1.2
  non_ssl_port_enabled = false
  tags = var.tags
}