terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-approle-vault"
    }
  }
}
