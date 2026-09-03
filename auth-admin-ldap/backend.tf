terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-admin-ldap"
    }
  }
}
