variable "route_table_name" {
  type        = string
  description = "The name of the Route Table"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the Route Table"
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  description = "List of routes to add to the Route Table"
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to associate with the Route Table"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Route Table"
  default     = {}
}