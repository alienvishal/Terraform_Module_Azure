variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the Virtual Network will be created"
}

variable "address_space" {
  type        = list(string)
  description = "List of address spaces for the Virtual Network"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags for the Virtual Network"
  default     = {}
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
}