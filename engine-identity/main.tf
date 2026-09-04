resource "vault_identity_entity" "workload_entities" {
  for_each = local.all_aliases

  name     = each.value.entity_name
  policies = each.value.policy

  metadata = {
    app           = each.value.app
    sub           = each.value.sub
    env           = each.value.env
    perms         = each.value.perms
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

resource "vault_policy" "workload_read_policy" {
  name = "workload-read-policy"

  policy = <<EOT
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

path "ad-corp/static-cred/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

path "ad-corp/static-cred/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["read"]
}

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

path "ad-corp/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.sub}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

path "ad-corp/rotate-role/{{identity.entity.metadata.app}}-{{identity.entity.metadata.env}}-*" {
  capabilities = ["update"]
}

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
