variable "openai_name" {
  description = "The name of the Azure OpenAI resource"
  type        = string
}

variable "rg_location" {
  description = "Azure region"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "SKU for the Azure OpenAI resource"
  type        = string
  default     = "S0"

  validation {
    condition     = contains(["S0", "S1"], var.sku_name)
    error_message = "SKU must be either 'S0' or 'S1'."
  }
}

variable "cognitive_deployment" {
  type = list(object({
    name = string
    rai_policy_name = optional(string, "Microsoft.Default")
    sku_name = string
    sku_capacity = number
    model_format = string
    model_name = string
    model_version = string
  }))
  default = []
  validation {
    condition = length(var.cognitive_deployment) > 0
    error_message = "Provide at least one cognitive_deployment in var.cognitive_deployment."
  }
  description = "(Optional) Provide the Cognitive deployment data to deploy model in openai"
}

variable "rai_policy" {
  type = list(object({
    name = string
    base_policy_name = string
    content_filter = list(object({
      name = string
      filter_enabled = optional(bool, true)
      block_enabled = optional(bool, true)
      severity_threshold = optional(string, "High")
      source = string
    }))
  }))
  default = []
  /*validation {
    condition = length(var.rai_policy) > 0
    error_message = "Provide at least one rai policy in var.rai_policy."
  }*/
  description = "(Optional) Provide the Cognitive deployment data to deploy model in openai"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "custom_subdomain_name" {
  description = "Custom subdomain for the Azure OpenAI endpoint"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{2,62}$", var.custom_subdomain_name))
    error_message = "Subdomain must start with a letter, be 3-63 characters, and contain only letters, digits, and hyphens."
  }
}


variable "public_network_access_enabled" {
  type = bool
  description = "Enable public network access to the account."
  default = true
}


variable "local_auth_enabled" {
  type = bool
  description = "Enable local (key-based) auth in addition to AAD."
  default = true
}


variable "network_acls" {
  description = <<EOT
    Optional network ACLs. Example:
    {
      default_action = "Deny"
      ip_rules = ["1.2.3.4"]
      virtual_network_rules = [
      {
        subnet_id = "/subscriptions/.../subnets/my-subnet"
        ignore_missing_vnet_service_endpoint = true
      }]
    }
  EOT
  type = object({
    default_action = string # "Allow" | "Deny"
    ip_rules = optional(list(string))
    virtual_network_rules = optional(list(object({
      subnet_id = string
      ignore_missing_vnet_service_endpoint = optional(bool)
    })))
  })
  default = null
}