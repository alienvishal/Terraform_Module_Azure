output "rds_id" {
  value = azurerm_redis_cache.rds.id
}

output "rds_primary_access_key" {
  value = azurerm_redis_cache.rds.primary_access_key
}

output "rds_primary_connection_string" {
  value = azurerm_redis_cache.rds.primary_connection_string
}

output "rds_host_name" {
  value = azurerm_redis_cache.rds.hostname
}