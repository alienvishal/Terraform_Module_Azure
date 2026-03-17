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

variable "tags" {
  type    = map(any)
  default = {}
}