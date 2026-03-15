variable "name" {
  type        = string
  description = "Provide the name of Log Analytics workspace"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "product_owner" {
  type        = string
  description = "Provide the product owner"
}

variable "project_name" {
  type        = string
  description = "Provide the Project name"
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