terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-oidc-okta"
    }
  }
}
