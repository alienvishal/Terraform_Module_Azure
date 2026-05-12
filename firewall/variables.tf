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
  description = "The ID of the Firewall Policy (optional)"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Azure Firewall"
  default     = {}
}