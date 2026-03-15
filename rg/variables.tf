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