resource "azurerm_linux_function_app" "linux_func" {
  count                      = var.os_type == "linux" ? 1 : 0
  name                       = var.name
  resource_group_name        = var.rg_name
  location                   = var.rg_location
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_primary_access_key
  service_plan_id            = var.app_svc_plan_id
  functions_extension_version = var.functions_extension_version
  tags = var.tags

  dynamic "identity" {
    for_each = var.system_identity == true ? ["enabled"] : []
    content {
      type = "SystemAssigned"
    }
  }

  site_config {
    always_on              = var.is_always_on
    ftps_state             = "FtpsOnly"
    minimum_tls_version    = "1.2"
    use_32_bit_worker      = false
    http2_enabled          = true
    vnet_route_all_enabled = var.vnet_route_all_enabled

    dynamic cors {
      for_each = length(var.allowed_origins) > 0 || var.support_credentials == true ? [1] : []
      content {
        allowed_origins = var.allowed_origins
        support_credentials = var.support_credentials
      }
    }

    application_stack {
      node_version   = try(var.node_version, null)
      python_version = try(var.python_version, null)
      dotnet_version = try(var.dotnet_version, null)
    }
  }

  app_settings = merge(
    var.app_settings,
    {
      "FUNCTIONS_WORKER_RUNTIME" = var.runtime
    },
    var.enable_app_insights ? {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = "${var.app_insight_instrument_key}"
      "APPINSIGHTS_PROFILERFEATURE_VERSION"        = "1.0.0"
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"        = "1.0.0"
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = "InstrumentationKey=${var.app_insight_instrument_key};IngestionEndpoint=https://${var.rg_location}-0.in.applicationinsights.azure.com/;LiveEndpoint=https://${var.rg_location}.livediagnostics.monitor.azure.com/"
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    } : {}
  )
  dynamic connection_string {
    for_each = try(var.connection_string != {} ? var.connection_string : {}, {})
    content {
      name = connection_string.key
      type = "Custom"
      value = connection_string.value  
    } 
  }
}

resource "azurerm_windows_function_app" "windows_func" {
  count = var.os_type == "windows" ? 1 : 0

  name                       = var.name
  resource_group_name        = var.rg_name
  location                   = var.rg_location
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_primary_access_key
  service_plan_id            = var.app_svc_plan_id
  vnet_image_pull_enabled    = var.vnet_image_pull_enabled
  functions_extension_version = var.functions_extension_version
  tags = var.tags

  site_config {
    always_on              = var.is_always_on
    ftps_state             = "FtpsOnly"
    minimum_tls_version    = "1.2"
    use_32_bit_worker      = false
    http2_enabled          = true
    vnet_route_all_enabled = var.vnet_route_all_enabled

    dynamic cors {
      for_each = length(var.allowed_origins) > 0 || var.support_credentials == true ? [1] : []
      content {
        allowed_origins = var.allowed_origins
        support_credentials = var.support_credentials
      }
    }

    application_stack {
      node_version   = try(var.node_version, null)
      dotnet_version = try(var.dotnet_version, null)
    }
  }

  app_settings = merge(
    var.app_settings,
    {
      "FUNCTIONS_WORKER_RUNTIME" = var.runtime
    },
    var.enable_app_insights ? {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = "${var.app_insight_instrument_key}"
      "APPINSIGHTS_PROFILERFEATURE_VERSION"        = "1.0.0"
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"        = "1.0.0"
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = "InstrumentationKey=${var.app_insight_instrument_key};IngestionEndpoint=https://${var.rg_location}-0.in.applicationinsights.azure.com/;LiveEndpoint=https://${var.rg_location}.livediagnostics.monitor.azure.com/"
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    } : {}
  )
  dynamic connection_string {
    for_each = try(var.connection_string != {} ? var.connection_string : {}, {})
    content {
      name = connection_string.key
      type = "Custom"
      value = connection_string.value  
    }
  }
}