variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}

variable "admin_ldap_domain" {
  type        = string
  description = "Domain component used in the admin LDAP secret path"
}

variable "admin_ldap_url" {
  type        = string
  description = "URL of the admin LDAP server"
}

variable "admin_ldap_bind_dn" {
  type        = string
  description = "Bind distinguished name used to query the admin LDAP directory"
}

variable "admin_ldap_bindpass_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only admin LDAP bind password"
  default     = 1
}

variable "admin_ldap_user_dn" {
  type        = string
  description = "Base distinguished name used to search for admin LDAP users"
}

variable "admin_read_only_group_sam_account_name" {
  type        = string
  description = "sAMAccountName of the LDAP group assigned the admin read-only policy"
}

variable "admin_read_write_group_sam_account_name" {
  type        = string
  description = "sAMAccountName of the LDAP group assigned the admin read-write policy"
}

variable "admin_ldap_group_search_dn" {
  type        = string
  description = "Base distinguished name used to search for admin LDAP groups"
}

variable "admin_ldap_upn_domain" {
  type        = string
  description = "User principal name domain for admin LDAP authentication"
}
