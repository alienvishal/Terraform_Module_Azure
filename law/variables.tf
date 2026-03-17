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

variable "tags" {
  type    = map(any)
  default = {}
}