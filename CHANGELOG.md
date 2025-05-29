# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-05-27

### Added
- Support for custom disable reasons when disabling security controls
- New `default_disabled_reason` variable to set default reason for disabled controls

### Breaking Changes
- Changed `disabled_controls` variable type from `map(list(string))` to `map(list(object({control_id=string,reason=optional(string)})))`
- Existing configurations will need to be updated to use the new variable structure

## [0.1.0] - 2025-05-26

### Added
- Initial release of the module
- Support for enabling AWS Security Hub in an AWS account/region
- Support for enabling specific security standards:
  - AWS Foundational Security Best Practices
  - CIS AWS Foundations Benchmark (v1.2.0 and v1.4.0)
  - PCI DSS
  - NIST SP 800-53
- Support for disabling specific security controls within standards
- Basic and complete usage examples
- Documentation including control reference and required permissions
