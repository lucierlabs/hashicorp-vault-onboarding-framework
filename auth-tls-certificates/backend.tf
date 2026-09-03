terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-tls-certificates"
    }
  }
}
