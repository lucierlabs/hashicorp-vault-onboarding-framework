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

variable "kubernetes_oidc_issuer" {
  type        = string
  description = "Kubernetes OIDC discovery URL and expected service account token issuer"
}

variable "kubernetes_audience" {
  type        = string
  description = "Audience required in Kubernetes service account tokens"
}
