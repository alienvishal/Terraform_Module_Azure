output "app_insight_id" {
  value = azurerm_application_insights.appinsight.id
}

output "app_insight_instrumentation" {
  value = azurerm_application_insights.appinsight.instrumentation_key
}

output "app_insight_connection_string" {
  value = azurerm_application_insights.appinsight.connection_string
}

output "app_insight_app_id" {
  value = azurerm_application_insights.appinsight.app_id
}