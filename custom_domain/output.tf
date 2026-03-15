output "custom_domain_id" {
  value = azurerm_app_service_custom_hostname_binding.appsvc_binding.id
}
output "virtual_ip" {
  value = azurerm_app_service_custom_hostname_binding.appsvc_binding.virtual_ip
}

output "hostname" {
  value = azurerm_app_service_custom_hostname_binding.appsvc_binding.hostname
}