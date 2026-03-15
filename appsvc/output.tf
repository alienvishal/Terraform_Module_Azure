output "appsvc_objectid" {
  value = var.system_identity == true && var.os_type == "Linux" ? azurerm_linux_web_app.linux_appsvc[0].identity[0].principal_id : var.system_identity == true ? azurerm_windows_web_app.appsvc[0].identity[0].principal_id : null
}
output "appsvc_name" {
  value = var.os_type == "Linux" ? azurerm_linux_web_app.linux_appsvc[0].name : azurerm_windows_web_app.appsvc[0].name
}
output "appsvc_default_host" {
  value = var.os_type == "Linux" ? azurerm_linux_web_app.linux_appsvc[0].default_hostname : azurerm_windows_web_app.appsvc[0].default_hostname
}