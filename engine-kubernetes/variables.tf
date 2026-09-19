variable "engine_kubernetes_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-kubernetes.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "kubernetes_clusters" {
  type = map(object({
    kubernetes_host                = string
    kubernetes_ca_cert             = string
    service_account_jwt_wo_version = optional(number, 1)
  }))
  description = "Kubernetes secrets engine configurations keyed by the short cluster name used in CSV inputs, Vault paths, and Terraform state"
  nullable    = false
}
