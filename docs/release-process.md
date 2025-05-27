# Release Process

This document explains the release process for this Terraform module.

## Automated Release Process

This repository uses GitHub Actions to automate the release process:

### 1. Tag and Release Workflow

The [Tag and Release](./.github/workflows/tag-release.yml) workflow automatically:

1. Extracts the latest version from `CHANGELOG.md`
2. Creates a Git tag for the version
3. Creates a GitHub release

**Trigger**: Pushes to the `main` branch that modify `.tf` files or `CHANGELOG.md`

### 2. Terraform Validation Workflow

The [Terraform Validation](./.github/workflows/terraform-validation.yml) workflow:

1. Validates Terraform syntax
2. Validates examples
3. Checks Terraform formatting

**Trigger**: All pushes and pull requests

## Manual Release Process

If you need to create a release manually:

1. Update the `CHANGELOG.md` with your changes under a new version
2. Merge your changes into the `main` branch
3. The GitHub Actions workflow will automatically create a tag and release

If the automated workflow fails or you need to create a manual tag:

```bash
git tag v0.1.0
git push origin v0.1.0
```

## Versioning

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR**: Incompatible API changes
- **MINOR**: Backward-compatible new features
- **PATCH**: Backward-compatible bug fixes

## Publishing to Terraform Registry

To publish the module to the Terraform Registry:

1. Ensure the repository is public on GitHub
2. Ensure you have a valid release tag
3. Visit the [Terraform Registry](https://registry.terraform.io/) and publish the module

## Post-Release Verification

After a release:

1. Verify the tag appears in GitHub
2. Verify the GitHub release page is correctly populated
3. If published to the Terraform Registry, verify it appears and can be used
4. Verify the examples work with the released version
