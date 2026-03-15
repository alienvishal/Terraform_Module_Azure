variable "rds_name" {
  type        = string
  description = "Provide the RDS name"
}

variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "rds_faimly" {
  type        = string
  description = "Provide the RDS Faimly"
  validation {
    condition     = contains(["C", "P"], upper(var.rds_faimly))
    error_message = "Provide the value in C (Basic/Standard) and P (Premium)"
  }
}

variable "rds_capacity" {
  type        = number
  description = "Provide the RDS Capacity"
}

variable "rds_sku" {
  type        = string
  description = "Provide the RDS SKU name"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.rds_sku)
    error_message = "Redis SKU should be [Basic, Standard, Premium]"
  }
}

variable "product_owner" {
  type        = string
  description = "Provide the Product Owner Name"
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
  type        = map(any)
  description = "Provide the tags"
  default     = {}
}