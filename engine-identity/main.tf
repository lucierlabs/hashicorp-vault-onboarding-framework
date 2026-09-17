resource "vault_identity_entity" "workload_entities" {
  for_each = local.all_aliases

  name     = each.value.entity_name
  policies = each.value.policy

  metadata = {
    app           = each.value.app
    sub           = each.value.sub
    env           = each.value.env
    perms         = each.value.perms
    app_id        = "${each.value.app}-${each.value.sub}-${each.value.env}"
    alias         = each.value.alias
    auth_path     = each.value.auth_path
    auth_accessor = each.value.auth_accessor
  }
}

resource "vault_identity_entity_alias" "workload_aliases" {
  for_each = local.all_aliases

  name           = each.value.alias
  mount_accessor = each.value.auth_accessor
  canonical_id   = vault_identity_entity.workload_entities[each.key].id
}

resource "vault_identity_oidc" "identity_tokens" {
  issuer = var.jwt_issuer
}

resource "vault_identity_oidc_role" "app_default_role" {
  name      = "app-default-role"
  key       = "default"
  client_id = "app-default-role"

  template = <<-EOT
{
  "app_id": {{identity.entity.metadata.app_id}},
  "entity_name": {{identity.entity.name}},
  "application": {{identity.entity.metadata.app}},
  "sub_application": {{identity.entity.metadata.sub}},
  "environment": {{identity.entity.metadata.env}},
  "permissions": {{identity.entity.metadata.perms}},
  "alias": {{identity.entity.metadata.alias}},
  "auth_path": {{identity.entity.metadata.auth_path}},
  "auth_accessor": {{identity.entity.metadata.auth_accessor}},
  "entity_metadata": {{identity.entity.metadata}}
}
EOT
}

resource "vault_identity_oidc_role" "external_default_roles" {
  for_each = toset([
    "aws",
    "azure",
    "terraform",
  ])

  name      = "${each.value}-default-role"
  key       = "default"
  client_id = "${each.value}-default-role"

  template = <<-EOT
{
  "app_id": {{identity.entity.metadata.app_id}},
  "entity_name": {{identity.entity.name}},
  "application": {{identity.entity.metadata.app}},
  "sub_application": {{identity.entity.metadata.sub}},
  "environment": {{identity.entity.metadata.env}},
  "permissions": {{identity.entity.metadata.perms}},
  "alias": {{identity.entity.metadata.alias}},
  "auth_path": {{identity.entity.metadata.auth_path}},
  "auth_accessor": {{identity.entity.metadata.auth_accessor}},
  "entity_metadata": {{identity.entity.metadata}}
}
EOT
}

resource "vault_policy" "workload_read_policy" {
  name = "workload-read-policy"

  policy = <<EOT
path "identity/oidc/token/app-default-role" {
  capabilities = ["read"]
}

path "identity/oidc/token/aws-default-role" {
  capabilities = ["read"]
}

path "identity/oidc/token/azure-default-role" {
  capabilities = ["read"]
}

path "identity/oidc/token/terraform-default-role" {
  capabilities = ["read"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["read"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["read", "list"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["read"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["read", "list"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/sys-secrets/*" {
  capabilities = ["read"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/sys-secrets/*" {
  capabilities = ["read", "list"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["read"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["read", "list"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["read"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["read", "list"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/sys-secrets/*" {
  capabilities = ["read"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/sys-secrets/*" {
  capabilities = ["read", "list"]
}

${join("\n\n", [
  for domain in sort(keys(var.active_directory_domains)) : <<-DOMAIN
path "ad-${domain}/static-cred/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "ad-${domain}/static-cred/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}
DOMAIN
])}

path "aws/sts/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "aws/sts/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "azure/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "azure/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "kubernetes-lab/creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "kubernetes-lab/creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "mysql/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "mysql/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "oracle/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "oracle/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "postgres/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "postgres/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "snowflake/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "snowflake/static-creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "terraform/creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "terraform/creds/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "workload_write_policy" {
  name = "workload-write-policy"

  policy = <<EOT
path "identity/oidc/token/app-default-role" {
  capabilities = ["read"]
}

path "identity/oidc/token/aws-default-role" {
  capabilities = ["read"]
}

path "identity/oidc/token/azure-default-role" {
  capabilities = ["read"]
}

path "identity/oidc/token/terraform-default-role" {
  capabilities = ["read"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.sub}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-data/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

path "kv/data/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

path "kv/metadata/{{identity.entity.metadata.app}}/{{identity.entity.metadata.env}}/app-secrets/*" {
  capabilities = ["create", "update", "patch", "delete"]
}

${join("\n\n", [
  for domain in sort(keys(var.active_directory_domains)) : <<-DOMAIN
path "ad-${domain}/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "ad-${domain}/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}
DOMAIN
])}

path "azure/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "azure/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "mysql/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "mysql/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "oracle/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "oracle/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "postgres/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "postgres/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "snowflake/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "snowflake/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

EOT
}
