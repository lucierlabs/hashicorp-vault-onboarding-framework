# HashiCorp Vault Onboarding Framework

An opinionated Terraform framework for standardized, self-service onboarding to HashiCorp Vault using identity-based ACL templates, governed secrets paths, and reusable policies.

## Assumptions and Limitations

This iteration of the framework uses VCS-backed workspaces in HCP Terraform for simplicity of demonstration.

The human authentication for applications teams is done via Okta OIDC based on group membership.  Human admin authentication is done via LDAP at auth/admin-ldap and Okta OIDC.

## Bootstrap Credential

The only required bootstrap authentication method is a manually created JWT auth method at `auth/admin-jwt-terraform`. It has a single role, `admin-auth-jwt-terraform`, bound to the `terraform_full_workspace` claim of the `auth-jwt-terraform-<environment>` HCP Terraform workspace. Create it separately in each Vault deployment, replacing the organization, project, and environment placeholders with the values for that deployment:

```shell
vault auth enable -path=admin-jwt-terraform jwt

vault write auth/admin-jwt-terraform/config \
  oidc_discovery_url=https://app.terraform.io \
  bound_issuer=https://app.terraform.io

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

vault write auth/admin-jwt-terraform/role/admin-auth-jwt-terraform \
  role_type=jwt \
  user_claim=terraform_full_workspace \
  bound_audiences=vault.workload.identity \
  bound_claims='{"terraform_full_workspace":"organization:<organization>:project:<project>:workspace:auth-jwt-terraform-<environment>"}' \
  token_policies=admin-auth-jwt-terraform-policy \
  token_ttl=14400
```

Configure the `auth-jwt-terraform-<environment>` workspace to use HCP Terraform's dynamic Vault provider credentials with `TFC_VAULT_AUTH_PATH=admin-jwt-terraform`, `TFC_VAULT_RUN_ROLE=admin-auth-jwt-terraform`, and `TFC_VAULT_WORKLOAD_IDENTITY_AUDIENCE=vault.workload.identity`. This bootstrap role and policy let that workspace create and manage the regular Terraform JWT auth method and the bootstrap policy for `engine-identity`; no static Vault credential or AppRole SecretID is required. All other authentication methods and engines use admin roles defined in the regular Terraform JWT auth method.

## Configuration Secrets

All configuration secrets are stored in a KV engine called admin-kv at paths matching the names of the directories in GitHub. Terraform ephemeral resources and write-only attributes are used to securely read the secrets from the admin-kv engine and write them to the respective authentication method or engine.

Per-instance engine configuration secrets use these paths and keys:

- `engine-ad/<domain>`, `engine-racf/<domain>`, `auth-ldap-ad/<domain>`, and `auth-ldap-racf/<domain>` use `bindpass_wo`.
- `engine-kubernetes/<cluster>` uses `service_account_jwt_wo`.
- `engine-mysql/<connection>`, `engine-oracle/<connection>`, and `engine-postgres/<connection>` use `password_wo` for the privileged database connection account.
- `engine-snowflake/<connection>` uses `private_key_wo` for the privileged Snowflake connection account.

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

The `active_directory_domains` map configures the AD secrets engine and the AD LDAP and Kerberos auth methods. Its keys are stable short domain names: the example `corp` key produces Terraform resource instances keyed by `["corp"]` and Vault paths such as `ad-corp`, `ldap-ad-corp`, and `kerberos-ad-corp`. Add another keyed object to configure another domain. Domain-specific write-only values are read from `admin-kv` at `engine-ad/<domain>`, `auth-ldap-ad/<domain>`, and `auth-kerberos-ad/<domain>`.

The `kubernetes_clusters` map configures both the Kubernetes JWT auth methods and Kubernetes secrets engines. Its keys are stable short cluster names: the example `lab` key produces Terraform resource instances keyed by `["lab"]` and Vault paths such as `jwt-kubernetes-lab` and `kubernetes-lab`. Add another keyed object to configure another cluster, and use the same key in the `cluster` columns of the Kubernetes CSV inputs. Cluster-specific write-only values are read from `admin-kv` at `engine-kubernetes/<cluster>`.

The `racf_domains` map configures both the RACF LDAP auth methods and RACF LDAP secrets engines. Its keys are stable short domain names: the example `mainframe` key produces Terraform resource instances keyed by `["mainframe"]` and Vault paths such as `ldap-racf-mainframe` and `racf-mainframe`. Use the same key in the `domain` columns of the RACF CSV inputs. Domain-specific write-only values are read from `admin-kv` at `auth-ldap-racf/<domain>` and `engine-racf/<domain>`.

CSV files keep one environment value per row. When using path-based VCS triggers, include the applicable file under `tfvars-environment` and the component's CSV file in addition to its Terraform working directory.

HCP Terraform workspaces use the name `<directory>-<environment>`, such as `auth-jwt-github-dev` or `engine-identity-prod`. The Identity workspace reads auth outputs from workspaces with its own environment suffix. Administrative workspace identities are generated from `input-files/admin-workspaces.csv`; the Identity workspace retains a dedicated JWT role so it can authenticate before creating the remaining admin entities and aliases.

Bootstrap each Vault deployment in this order:

1. Create the bootstrap admin-jwt-terraform auth method manually.
2. Run `auth-jwt-terraform-<environment>` with the `admin-auth-jwt-terraform` role on the bootstrap `admin-jwt-terraform` auth method so it creates the regular JWT backend, `admin-default-role`, and the explicit `admin-engine-identity` role and policy.
3. Run `engine-identity-<environment>` with `admin-engine-identity` so it creates the admin policies, entities, and aliases from `admin-workspaces.csv`.
4. Run `engine-kv-<environment>` so it creates the `admin-kv` engine for configuration secrets
5. Populate the `admin-kv` with the configuration secrets.
6. Run the remaining `auth-*` and `engine-*` workspaces with `admin-default-role`; their workspace claim resolves to the environment-specific admin entity and policy.

## Independent project

This is an independent project and is not affiliated with, sponsored by, or endorsed by HashiCorp, Inc.

HashiCorp and Vault are trademarks of HashiCorp, Inc. Their use here is solely to identify this project's compatibility with HashiCorp Vault. See [TRADEMARKS.md](TRADEMARKS.md) for details.

## License

The source code in this repository is licensed under the [Mozilla Public License 2.0](LICENSE). You may use it for any purpose, including commercially, subject to the license terms.

Copyright remains with the respective copyright holders. The license grants permissions to use the code; it does not transfer copyright ownership.

Contributions are accepted under the same license. See [CONTRIBUTING.md](CONTRIBUTING.md).
