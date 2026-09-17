variable "auth_jwt_kubernetes_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-kubernetes.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}

variable "kubernetes_clusters" {
  type = map(object({
    kubernetes_oidc_issuer = string
    kubernetes_audience    = string
  }))
  description = "Kubernetes cluster configurations keyed by the short cluster name used in Vault paths and Terraform state"
  nullable    = false
}
