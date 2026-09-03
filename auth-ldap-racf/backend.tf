terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-ldap-racf"
    }
  }
}
