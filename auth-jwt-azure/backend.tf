terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-jwt-azure"
    }
  }
}
