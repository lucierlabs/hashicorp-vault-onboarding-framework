terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "auth-sts-aws"
    }
  }
}
