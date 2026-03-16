variable "cluster_name" {
    type = string
    description = "Provide the Cluster Name"
}
variable "location" {
    type = string
    description = "Provide the Location for the Cluster"
}
variable "resource_group" {
    type = string
    description = "Provide the Resource Group Name for the Cluster"
}
variable "dns_prefix" {
    type = string
    description = "Provide the DNS Prefix for the Cluster"
}

variable "kubernetes_version" {
    type = string
    description = "Provide the Kubernetes Version for the Cluster (optional)"
    default = null
}

variable "tags" {
  type = map(string)
  description = "Provide the tags"
  default = {}
}

variable "default_node_pool_name" {
    type = string
    description = "Provide the name for the default node pool"
}

variable "default_node_pool_node_count" {
    type = number
    description = "Provide the node count for the default node pool" 
}

variable "default_node_pool_vm_size" {
    type = string
    description = "Provide the VM size for the default node pool"
}

variable "default_node_pool_vnet_subnet_id" {
    type = string
    description = "Provide the subnet ID for the default node pool"
}

variable "default_node_pool_min_count" {
  type = number
  description = "Provide the minimum node count for the default node pool (Optional)"
  default = 1
}

variable "default_node_pool_max_count" {
  type = number
  description = "Provide the maximum node count for the default node pool (Optional)"
  default = 3
}

variable "node_pools" {
  type = map(object({
    vm_size     = string
    min_count   = number
    max_count   = number
    subnet_id   = string
    node_labels = optional(map(string), {})
    node_taints = optional(list(string), [])
  }))
   description = "Provide the configuration for additional node pools (optional)"
   default = {}
    
}

variable "role_based_access_control_enabled" {
  type = bool
  description = "Is Role based access control enabled"
  default = true
}

variable "azure_active_directory_role_based_access_control" {
  type = object({
    azure_rbac_enabled = bool
    admin_group_object_ids = list(string)
  })
  description = "Provide the configuration for Azure Active Directory Role Based Access Control (optional)"
  default = null
}

variable "log_analytics_workspace_id" {
  type = string
  description = "Provide the Log Analytics Workspace ID for monitoring (optional)"
  default = null
}
