variable "rg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "identity" {
  type = object({
    type = string
    identity_ids = optional(list(string))
  })
  default = null
  description = "(Optional) Provide the Idenity Name"
  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned,UserAssigned"], var.identity.type)
    error_message = "identity.type must be SystemAssigned, UserAssigned, or SystemAssigned,UserAssigned."
  }
}

variable "autoscale_configuration" {
  description = "Autoscale configuration block (null to disable)"
  type = object({
    min_capacity = number
    max_capacity = number
  })
  default = null
  validation {
    condition     = var.autoscale_configuration == null || (var.autoscale_configuration.min_capacity >= 0 && var.autoscale_configuration.max_capacity >= var.autoscale_configuration.min_capacity)
    error_message = "Autoscale min_capacity must be >= 0 and max_capacity must be >= min_capacity."
  }
}

variable "waf_configuration" {
  description = "Web Application Firewall configuration (null to disable)"
  type = object({
    enabled                  = bool
    firewall_mode            = string       # Prevention or Detection
    rule_set_version         = string       # Example: 3.2
    request_body_check       = optional(bool)
    file_upload_limit_mb     = optional(number)
    max_request_body_size_kb = optional(number)
  })
  default = null
  validation {
    condition     = var.waf_configuration == null || contains(["Detection", "Prevention"], var.waf_configuration.firewall_mode)
    error_message = "firewall_mode must be either Detection or Prevention."
  }
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "app_gateway_name" {
  type        = string
  description = "provide application gateway name"
}

variable "subnet_id" {
  type        = string
  description = "provide subnet id"
}

variable "public_ip_id" {
  type        = string
  description = "provide the public ip id"
}

variable "sku_name" {
  type        = string
  default     = "WAF_v2"
  description = "(optional) provide the sku name"
}

variable "sku_tier" {
  type        = string
  default     = "WAF_v2"
  description = "(optional) provide the sku tier"
}

variable "frontend_ports" {
  type = list(object({
    name = string
    port = number
  }))
  description = "provide the front end port"
}

variable "listeners" {
  type = list(object({
    name                 = string
    frontend_port_name   = string
    protocol             = string
    ssl_certificate_name = string
  }))
  description = "provide the listners"
}

variable "backend_pools" {
  type = list(object({
    name              = string
    backend_addresses = list(string)
  }))
  description = "provide the backend pools"
}

variable "probes" {
  type = list(object({
    name                                      = string
    protocol                                  = string
    host                                      = string
    path                                      = string
    interval                                  = number
    timeout                                   = number
    unhealthy_threshold                       = number
    pick_host_name_from_backend_http_settings = bool
    match_status_codes                        = list(string)
  }))
  description = "provide the probes"
}

variable "rules" {
  type = list(object({
    name                       = string
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = number
  }))
  description = "provide the rules"
}

variable "backend_http_settings" {
  type = list(object({
    name                  = string
    port                  = number
    protocol              = string
    cookie_based_affinity = string
    request_timeout       = number
    probe_name            = string
    path                  = string
  }))
}

variable "ssl_certificate" {
  type = object({
    name               = string
    keyvault_secret_id = string
  })

}
