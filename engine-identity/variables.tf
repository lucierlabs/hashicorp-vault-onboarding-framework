variable "hcp_terraform_workspace_environment" {
  type        = string
  description = "Environment suffix used by HCP Terraform workspace names"
}

variable "active_directory_domains" {
  type        = map(any)
  description = "Active Directory domain configurations keyed by the short domain name used in Vault paths"
  nullable    = false
}

variable "kubernetes_clusters" {
  type        = map(any)
  description = "Kubernetes cluster configurations keyed by the short cluster name used in Vault auth paths"
  nullable    = false
}
