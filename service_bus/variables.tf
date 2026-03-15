variable "name" {
  type        = string
  description = "Service Bus Namespace"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "sku" {
  description = "SKU for Service Bus (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "queues" {
  type = list(object({
    name                     = string
    max_delivery_count       = optional(string)
    lock_duration            = optional(string)
    enable_partitioning      = optional(bool)
    max_size_in_megabytes    = optional(number)
    defaultMessageTimeToLive = optional(string)
    status                   = optional(string)
  }))
  default     = []
  description = "(Optional)List of queues to create"
}

variable "topics" {
  description = "(Optional)List of topics and optional subscriptions"
  type = list(object({
    name                = string
    enable_partitioning = optional(bool)
    subscriptions = optional(list(object({
      name               = string
      max_delivery_count = optional(number, 10)
      lock_duration      = optional(string, "PT1M")
    })))
  }))
  default = []
}


variable "product_owner" {
  type = string
}

variable "project_name" {
  type = string
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