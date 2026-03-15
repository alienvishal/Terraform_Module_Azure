resource "azurerm_windows_web_app" "appsvc" {
  count = var.os_type == "Windows" ? 1 : 0

  name                      = var.name
  resource_group_name       = var.rg_name
  location                  = var.rg_location
  service_plan_id           = var.app_svc_plan_id
  virtual_network_subnet_id = var.subnet_id
  https_only                = var.is_https_only

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
    app_command_line       = try(var.app_command_line, null) 
    
    dynamic cors {
      for_each = length(var.allowed_origins) > 0 || var.support_credentials == true ? [1] : []
      content {
        allowed_origins = var.allowed_origins
        support_credentials = var.support_credentials
      }
    }

    application_stack {
      current_stack       = try(var.current_stack, null)
      dotnet_version      = try(var.dotnet_version, null)
      dotnet_core_version = try(var.dotnet_core_version, null)
      tomcat_version      = try(var.tomcat_version, null)
      java_version        = try(var.java_version, null)
      node_version        = try(var.node_version, null)
      php_version         = try(var.php_version, null)
      python              = try(var.python, false)
    }
  }

  app_settings = merge(
    var.app_settings,
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

  tags = merge(
    {
      Owner         = var.product_owner,
      Department    = var.department
      "Cost Center" = var.cost_center
      ProjectName   = var.project_name,
      deployment    = "terraform"
    },
  var.tags)
}

resource "azurerm_linux_web_app" "linux_appsvc" {
  count = var.os_type == "Linux" ? 1 : 0

  name                      = var.name
  resource_group_name       = var.rg_name
  location                  = var.rg_location
  service_plan_id           = var.app_svc_plan_id
  virtual_network_subnet_id = var.subnet_id
  https_only                = var.is_https_only

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
    app_command_line       = try(var.app_command_line, null)
    
    dynamic cors {
      for_each = length(var.allowed_origins) > 0 || var.support_credentials == true ? [1] : []
      content {
        allowed_origins = var.allowed_origins
        support_credentials = var.support_credentials
      }
    }

    application_stack {
      dotnet_version      = try(var.dotnet_version, null)
      java_version        = try(var.java_version, null)
      node_version        = try(var.node_version, null)
      php_version         = try(var.php_version, null)
      python_version      = try(var.python_version, null) 
    }
  }

  app_settings = merge(
    var.app_settings,
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

  tags = merge(
    {
      Owner         = var.product_owner,
      Department    = var.department
      "Cost Center" = var.cost_center
      ProjectName   = var.project_name,
      deployment    = "terraform"
    },
  var.tags)
}