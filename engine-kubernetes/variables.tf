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

variable "kubernetes_host" {
  type        = string
  description = "URL of the Kubernetes API server used by the Kubernetes secrets engine"
}

variable "kubernetes_ca_cert" {
  type        = string
  description = "PEM-encoded CA certificate used to verify the Kubernetes API server"
}

variable "vault_kubernetes_service_account_jwt_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Kubernetes service account JWT"
  default     = 1
}
