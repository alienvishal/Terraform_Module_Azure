# This resource block is used to create the custom host binding in App Service
resource "azurerm_app_service_custom_hostname_binding" "appsvc_binding" {

  hostname            = var.hostname
  app_service_name    = var.app_svc_name
  resource_group_name = var.rg_name
  ssl_state           = "SniEnabled"
  thumbprint          = var.thumbprint
}