output "environments" {
  description = "Unique environments discovered in admin-roles.csv."
  value       = local.environments
}

output "workspace_count" {
  description = "Total number of HCP Terraform workspaces managed by this factory."
  value       = length(local.workspaces)
}

output "workspace_names" {
  description = "HCP Terraform workspace names managed by this factory."
  value       = sort(keys(local.workspaces))
}
