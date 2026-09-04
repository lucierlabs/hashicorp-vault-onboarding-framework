terraform {
  cloud {
    organization = "lucierlabs"
    workspaces {
      name = "engine-oracle"
    }
  }
}
