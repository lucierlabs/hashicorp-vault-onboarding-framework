# HashiCorp Vault Onboarding Framework

An opinionated Terraform framework for standardized, self-service onboarding to HashiCorp Vault using identity-based ACL templates, governed secrets paths, and reusable policies.

## Assumptions and Limitations

This iteration of the framework uses VCS-backed workspaces in HCP Terraform for simplicity of demonstration.  This means that it does not contain the full release envrionment abstraction that would be possible if using a full CI/CD tool such as GitHub Actions or Harness.

The human authentication for applications teams is done via Okta OIDC based on group membership.  Admin authentication available via LDAP and Okta OIDC.

## Independent project

This is an independent project and is not affiliated with, sponsored by, or endorsed by HashiCorp, Inc.

HashiCorp and Vault are trademarks of HashiCorp, Inc. Their use here is solely to identify this project's compatibility with HashiCorp Vault. See [TRADEMARKS.md](TRADEMARKS.md) for details.

## License

The source code in this repository is licensed under the [Mozilla Public License 2.0](LICENSE). You may use it for any purpose, including commercially, subject to the license terms.

Copyright remains with the respective copyright holders. The license grants permissions to use the code; it does not transfer copyright ownership.

Contributions are accepted under the same license. See [CONTRIBUTING.md](CONTRIBUTING.md).
