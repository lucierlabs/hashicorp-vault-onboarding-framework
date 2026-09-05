# HashiCorp Vault Onboarding Framework

An opinionated Terraform framework for standardized, self-service onboarding to HashiCorp Vault using identity-based ACL templates, governed secrets paths, and reusable policies.

## Assumptions and Limitations

This iteration of the framework uses VCS-backed workspaces in HCP Terraform for simplicity of demonstration.

The human authentication for applications teams is done via Okta OIDC based on group membership.  Human admin authentication is done via LDAP at auth/admin-ldap and Okta OIDC.

## Bootstrap Credential

The only required bootstrap credential is a manually created AppRole auth method at `auth/admin-approle`. Create the `admin-auth-jwt-terraform-policy`, assign it to a role named `admin-auth-jwt-terraform`, and use the same name as the RoleID:

```shell
vault auth enable -path=admin-approle approle

vault policy write admin-auth-jwt-terraform-policy - <<'EOF'
path "auth/token/create" {
  capabilities = ["update"]
}

path "sys/auth/jwt-terraform" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/jwt-terraform" {
  capabilities = ["read"]
}

path "sys/mounts/auth/jwt-terraform/tune" {
  capabilities = ["read", "update"]
}

path "auth/jwt-terraform/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "sys/policies/acl/admin-engine-identity-policy" {
  capabilities = ["create", "read", "update", "delete"]
}
EOF

vault write auth/admin-approle/role/admin-auth-jwt-terraform \
  token_policies=admin-auth-jwt-terraform-policy

vault write auth/admin-approle/role/admin-auth-jwt-terraform/role-id \
  role_id=admin-auth-jwt-terraform

vault write -force auth/admin-approle/role/admin-auth-jwt-terraform/secret-id
```

The `auth-jwt-terraform` workspace uses this AppRole and policy to create and manage the Terraform JWT auth method and the bootstrap policy for `engine-identity`. Store its generated SecretID in HCP Terraform as a sensitive Terraform variable named `admin_approle_secret_id`. All other authentication methods and engines use admin roles defined in the Terraform JWT auth method.

## Configuration Secrets

All configuration secrets are stored in a KV engine called admin-kv at paths matching the names of the directories in GitHub.  Terraform ephemeral resources and write-only attributes are used to securely read the secrets from the admin-kv engine and write them to the respective authenticaiton method or engine.

## Environment Configuration

The HCP Terraform workspaces use the VCS workflow and set their Terraform Working Directory to the applicable `auth-*` or `engine-*` directory. The root configurations intentionally do not contain `cloud` blocks because local CLI plans and applies are outside this framework's workflow.

Each workspace selects one checked-in environment file through this HCP Terraform environment variable:

```text
TF_CLI_ARGS=-var-file=../tfvars-environment/dev.tfvars
```

Use `test.tfvars` or `prod.tfvars` for the corresponding Vault deployment. Keep ordinary environment configuration in these files and credentials or dynamic credential settings in HCP Terraform.

The `environments` set in each file defines which application environment values that Vault deployment accepts from the combined CSV inputs. Auth methods and CSV-backed engines select rows with:

```hcl
if contains(var.environments, row.environment)
```

CSV files keep one environment value per row. When using path-based VCS triggers, include the applicable file under `tfvars-environment` and the component's CSV file in addition to its Terraform working directory.

HCP Terraform workspaces use the name `<directory>-<environment>`, such as `auth-jwt-github-dev` or `engine-identity-prod`. The Identity workspace reads auth outputs from workspaces with its own environment suffix. Administrative workspace identities are generated from `input-files/admin-roles.csv`; the Identity workspace retains a dedicated JWT role so it can authenticate before creating the remaining admin entities and aliases.

Bootstrap each Vault deployment in this order:

1. Run `auth-jwt-terraform-<environment>` with the bootstrap AppRole so it creates the JWT backend, `admin-default-role`, and the explicit `admin-engine-identity` role and policy.
2. Run `engine-identity-<environment>` with `admin-engine-identity` so it creates the admin policies, entities, and aliases from `admin-roles.csv`.
3. Run the remaining `auth-*` and `engine-*` workspaces with `admin-default-role`; their workspace claim resolves to the environment-specific admin entity and policy.

## Independent project

This is an independent project and is not affiliated with, sponsored by, or endorsed by HashiCorp, Inc.

HashiCorp and Vault are trademarks of HashiCorp, Inc. Their use here is solely to identify this project's compatibility with HashiCorp Vault. See [TRADEMARKS.md](TRADEMARKS.md) for details.

## License

The source code in this repository is licensed under the [Mozilla Public License 2.0](LICENSE). You may use it for any purpose, including commercially, subject to the license terms.

Copyright remains with the respective copyright holders. The license grants permissions to use the code; it does not transfer copyright ownership.

Contributions are accepted under the same license. See [CONTRIBUTING.md](CONTRIBUTING.md).
