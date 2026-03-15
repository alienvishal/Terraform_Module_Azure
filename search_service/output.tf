output "id" {
  description = "The ID of the Azure Cognitive Search service."
  value       = azurerm_search_service.search_service.id
}

output "name" {
  description = "The name of the Azure Cognitive Search service."
  value       = azurerm_search_service.search_service.name
}

output "primary_key" {
  description = "The primary key of the search service."
  value       = azurerm_search_service.search_service.primary_key
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary key of the search service."
  value       = azurerm_search_service.search_service.secondary_key
  sensitive   = true
}