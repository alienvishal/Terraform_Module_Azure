resource "azurerm_application_gateway" "appgw" {
  name                = var.app_gateway_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku {
    name     = var.sku_name
    tier     = var.sku_tier
  }

  dynamic identity {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type = lookup(identity.value, "type", "SystemAssigned")
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic autoscale_configuration {
    for_each = var.autoscale_configuration != null ? [var.autoscale_configuration] : []
    content {
      min_capacity = autoscale_configuration.value.min_capacity
      max_capacity = autoscale_configuration.value.max_capacity
    }
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_id
  }

  ssl_policy {
    policy_type          = "Custom"
    min_protocol_version = "TLSv1_2"
    cipher_suites = [
      "TLS_RSA_WITH_AES_256_CBC_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",
      "TLS_DHE_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_RSA_WITH_AES_128_CBC_SHA256",
      "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA",
      "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",
      "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
      "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
      "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
      "TLS_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_RSA_WITH_AES_256_CBC_SHA",
      "TLS_RSA_WITH_AES_128_CBC_SHA"
    ]
  }

  dynamic "frontend_port" {
    for_each = { for port in var.frontend_ports : port.name => port }
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = var.public_ip_id
  }

  # WAF Configuration
  dynamic "waf_configuration" {
    for_each = var.waf_configuration != null ? [var.waf_configuration] : []
    content {
      enabled                  = waf_configuration.value.enabled
      firewall_mode            = waf_configuration.value.firewall_mode
      rule_set_type            = "OWASP"
      rule_set_version         = waf_configuration.value.rule_set_version
      request_body_check       = lookup(waf_configuration.value, "request_body_check", true)
      file_upload_limit_mb     = lookup(waf_configuration.value, "file_upload_limit_mb", 100)
      max_request_body_size_kb = lookup(waf_configuration.value, "max_request_body_size_kb", 128)
    }
  }

  ssl_certificate {
    name                = var.ssl_certificate.name
    key_vault_secret_id = var.ssl_certificate.keyvault_secret_id
  }

  dynamic "http_listener" {
    for_each = { for listener in var.listeners : listener.name => listener }
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = "appGatewayFrontendIP"
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      host_name                      = http_listener.value.name
    }
  }

  dynamic "backend_address_pool" {
    for_each = { for pool in var.backend_pools : pool.name => pool }
    content {
      name = backend_address_pool.value.name
      ip_addresses = backend_address_pool.value.backend_addresses
    }

  }

  dynamic "backend_http_settings" {
    for_each = { for setting in var.backend_http_settings : setting.name => setting }
    content {
      name                  = backend_http_settings.value.name
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      request_timeout       = backend_http_settings.value.request_timeout
      probe_name            = backend_http_settings.value.probe_name
      path                  = backend_http_settings.value.path 
    }
  }

  dynamic "probe" {
    for_each = { for probe in var.probes : probe.name => probe }
    content {
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      host                                      = probe.value.host
      path                                      = probe.value.path
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      match {
        status_code = probe.value.match_status_codes
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = { for rule in var.rules : rule.name => rule }
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
      priority                   = request_routing_rule.value.priority
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
