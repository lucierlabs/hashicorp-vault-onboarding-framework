# Vault Terraform workspace factory

This root module creates the HCP Terraform workspaces for the Vault onboarding
framework. It intentionally declares no Terraform input variables. Configuration
is held in `locals.tf`, and workspace inventory is read from
`../input-files/admin-workspaces.csv`.

For every unique CSV environment, the factory also creates:

- `auth-jwt-terraform-<environment>`
- `engine-identity-<environment>`

All workspaces except `auth-jwt-terraform-*` receive Vault provider workload
identity environment variables. Identity workspaces authenticate with
`admin-engine-identity`; the remaining WIF-enabled workspaces use
`admin-default-role`. Every workspace receives a single `TF_CLI_ARGS`
environment variable that selects its checked-in environment tfvars file for
all Terraform CLI commands.

## Before the first apply

1. Confirm `organization_name`, `project_name`, the VCS settings, and all values
   in `vault_addrs` in `locals.tf`.
2. Ensure the named HCP Terraform project and `lucierlabs` HCP Terraform GitHub
   App installation already exist.
3. Define `TFE_TOKEN` in the factory workspace environment. The token must be
   allowed to read the project and GitHub App installation and manage workspaces
   and workspace variables.
4. After creation, add the sensitive Terraform variable
   `admin_approle_secret_id` separately to every `auth-jwt-terraform-*`
   workspace. This factory does not accept or store that bootstrap secret.

New workspaces have automatic apply disabled and `queue_all_runs = false`, so
they do not all start before the Vault authentication bootstrap is ready. Run
each environment in this order:

1. `auth-jwt-terraform-<environment>`
2. `engine-identity-<environment>`
3. The remaining environment workspaces
