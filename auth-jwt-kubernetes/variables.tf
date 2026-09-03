variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-kubernetes.csv"
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
