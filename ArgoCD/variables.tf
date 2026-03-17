variable "kube_config_host" {
  type = string
  description = "Provide the kube_config_host"
}

variable "client_certificate" {
  type = string
  description = "Provide the client_certificate"
}

variable "client_key" {
  type = string
  description = "Provide the client_key"
}

variable "cluster_ca_certificate" {
  type = string
  description = "Provide the cluster_ca_certificate"
}