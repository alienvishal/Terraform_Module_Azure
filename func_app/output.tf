output "function_app_name" {
  value = var.os_type == "linux" ? azurerm_linux_function_app.linux_func[0].name : azurerm_windows_function_app.windows_func[0].name
}

output "default_hostname" {
  value = var.os_type == "linux" ? azurerm_linux_function_app.linux_func[0].default_hostname : azurerm_windows_function_app.windows_func[0].default_hostname
}

output "func_app_object" {
  value = var.system_identity == true && var.os_type == "linux" ? azurerm_linux_function_app.linux_func[0].identity[0].principal_id : var.system_identity == true ? azurerm_windows_function_app.windows_func[0].identity[0].principal_id : null
}