terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-msi-azure"
    }
  }
}
