terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-kerberos-ad"
    }
  }
}
