variable "firewall_name" {
  type        = string
  description = "The name of the Azure Firewall"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the Azure Firewall"
}

variable "sku_name" {
  type        = string
  description = "The SKU name of the Azure Firewall (AZFW_VNet or AZFW_Hub)"
  default     = "AZFW_VNet"
}

variable "sku_tier" {
  type        = string
  description = "The SKU tier of the Azure Firewall (Standard or Premium)"
  default     = "Standard"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet for the Azure Firewall"
}

variable "public_ip_address_id" {
  type        = string
  description = "The ID of the public IP address for the Azure Firewall"
}

variable "firewall_policy_id" {
  type        = string
  description = "The ID of the Firewall Policy (optional). If not provided, a new policy will be created."
  default     = null
}

variable "firewall_policy_name" {
  type        = string
  description = "The name of the Firewall Policy (used if creating a new policy)"
  default     = null
}

variable "rule_collection_groups" {
  type = list(object({
    name     = string
    priority = number
    application_rule_collections = optional(list(object({
      name     = string
      priority = number
      action   = string
      rules = list(object({
        name = string
        protocols = list(object({
          port = string
          type = string
        }))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        destination_urls      = optional(list(string))
        terminate_tls         = optional(bool)
        web_categories        = optional(list(string))
      }))
    })))
    network_rule_collections = optional(list(object({
      name     = string
      priority = number
      action   = string
      rules = list(object({
        name                  = string
        protocols             = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_ports     = list(string)
      }))
    })))
    nat_rule_collections = optional(list(object({
      name     = string
      priority = number
      action   = string
      rules = list(object({
        name                = string
        protocols           = list(string)
        source_addresses    = optional(list(string))
        source_ip_groups    = optional(list(string))
        destination_address = optional(string)
        destination_ports   = optional(list(string))
        translated_address  = optional(string)
        translated_port     = optional(string)
        translated_fqdn     = optional(string)
      }))
    })))
  }))
  description = "List of rule collection groups for the firewall policy"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Azure Firewall"
  default     = {}
}