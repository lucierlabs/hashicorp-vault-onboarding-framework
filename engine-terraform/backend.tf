terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "engine-terraform"
    }
  }
}
