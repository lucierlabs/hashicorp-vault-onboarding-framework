variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-kerberos-ad.csv"
}

variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}

variable "kerberos_service_account" {
  type        = string
  description = "Kerberos service principal used by the Vault auth method"
}

variable "kerberos_keytab_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Kerberos keytab"
  default     = 1
}

variable "kerberos_ldap_url" {
  type        = string
  description = "URL of the LDAP server used by the Kerberos auth method"
}

variable "kerberos_ldap_bind_dn" {
  type        = string
  description = "Bind distinguished name used to query LDAP for Kerberos identities"
}

variable "kerberos_ldap_bindpass_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Kerberos LDAP bind password"
  default     = 1
}

variable "kerberos_ldap_user_dn" {
  type        = string
  description = "Base distinguished name used to search for Kerberos users"
}

variable "kerberos_group_sam_account_name" {
  type        = string
  description = "sAMAccountName of the Active Directory group permitted to authenticate with Kerberos"
}

variable "kerberos_ldap_group_dn" {
  type        = string
  description = "Base distinguished name used to search for Kerberos groups"
}

variable "kerberos_upn_domain" {
  type        = string
  description = "User principal name domain for Kerberos authentication"
}
