variable "name" {
  description = "The name of the Public IP."
  type        = string
}

variable "allocation_method" {
  description = "Defines the allocation method for the Public IP. Possible values are Static or Dynamic."
  type        = string
  default     = "Static"

  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "allocation_method must be either 'Static' or 'Dynamic'."
  }
}

variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic or Standard."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "sku must be either 'Basic' or 'Standard'."
  }
}

variable "zones" {
  description = "A list of availability zones to assign the public IP to (only supported for Standard SKU)."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.zones) == 0 || var.sku == "Standard"
    error_message = "zones can only be set when sku = 'Standard'."
  }
}

variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "product_owner" {
  type        = string
  description = "Provide the Product Owner name"
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