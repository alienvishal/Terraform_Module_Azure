variable "name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "law_id" {
  type = string
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