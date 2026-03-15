variable "access_policy" {
  type = list(object({
    object_id               = list(string)
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
    storage_permissions     = optional(list(string), [])
  }))
  description = "(Optional) Provide the access policy details"
  default     = []
}

variable "kv_name" {
  type        = string
  description = "Provide the Key Vault Name"
}

variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "rg_location" {
  type        = string
  description = "Provide the Resource group location"
}

variable "sku_name" {
  type        = string
  description = "Provide the SKU."
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Please provide the value either standard or premium"
  }
}

variable "is_purge_protection_enabled" {
  type        = bool
  description = "(Optional) Is Purge Protection enabled ? Default is False"
  default     = false
}

variable "soft_delete_retention_days" {
  type        = number
  description = "(Optional) Provide soft delete retention days ? Default is 7"
  default     = 7
}

variable "is_public_network_access_enabled" {
  type        = bool
  description = "(Optional) Is Public network enabled ? Default is True"
  default     = true
}

variable "product_owner" {
  type        = string
  description = "Provide the Product owner name"
}

variable "project_name" {
  type        = string
  description = "Provide the Project Name"
}

variable "department" {
  type        = string
  description = "Provide the Department name"
}

variable "cost_center" {
  type        = string
  description = "Provide the Cost Center"
}

variable "tags" {
  type    = map(any)
  default = {}
}