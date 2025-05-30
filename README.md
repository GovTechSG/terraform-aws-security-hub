# terraform-aws-security

This Terraform module enables and configures AWS Security Hub for your AWS account. It allows you to:

- Enable AWS Security Hub in your account/region
- Select and enable specific Security Hub standards (rulesets), such as AWS Foundational Security Best Practices, CIS, PCI DSS, etc.
- Disable specific controls (rules) within each enabled ruleset, providing fine-grained control over your security findings

The module is designed for use in GCC2.0 projects but is generally applicable to any AWS environment.

## Features

- Enable AWS Security Hub
- Enable one or more Security Hub standards (rulesets)
- Disable specific controls within enabled standards
- Flexible input variables for customization
- Outputs for integration and status reporting
- Cross-region and cross-account support
- Tag support for all created resources

## Usage Example

```hcl
module "security_hub" {
  source = "github.com/govtechsg/terraform-aws-security-hub"

  enable_standards = [
    "aws-foundational-security-best-practices",
    "cis-aws-foundations-benchmark"
  ]

  disabled_controls = {
    "aws-foundational-security-best-practices" = [
      {
        control_id = "IAM.1"
        reason     = "Root account required for automation"
      },
      {
        control_id = "EC2.10"
        reason     = "Using alternative VPC architecture"
      }
    ]
    "cis-aws-foundations-benchmark" = [
      {
        control_id = "1.10"
      },  # Will use default reason
      {
        control_id = "2.7"
        reason     = "Using alternative encryption mechanism"
      }
    ]
  }

  # Optional: Set default reason for disabled controls
  default_disabled_reason = "Disabled as per security policy"

  tags = {
    Environment = "production"
    Project     = "security-compliance"
  }
}
```

## Requirements

- Terraform >= 1.0
- AWS provider >= 4.0

For details on required AWS permissions, see the [Permissions Guide](./docs/permissions.md).

## Supported Security Standards

This module supports the following AWS Security Hub standards:

1. **AWS Foundational Security Best Practices (FSBP)**
   - ID: `aws-foundational-security-best-practices`
   - Includes security best practices recommended by AWS security experts

2. **CIS AWS Foundations Benchmark**
   - ID: `cis-aws-foundations-benchmark` (defaults to v1.4.0)
   - Specific version v1.4.0: `cis-aws-foundations-benchmark-v1.4.0`
   - Specific version v3.0.0: `cis-aws-foundations-benchmark-v3.0.0`
   - Industry standard best practices for securing AWS

3. **Payment Card Industry Data Security Standard (PCI DSS)**
   - ID: `pci-dss`
   - Requirements for handling credit card information

4. **NIST SP 800-53 Rev. 5**
   - ID: `nist-800-53`
   - Security and privacy controls standard

For a detailed list of controls that can be disabled, see the [Security Controls Reference](./docs/security-controls-reference.md).

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `enabled` | Whether to enable AWS Security Hub | `bool` | `true` | no |
| `enable_standards` | List of security standards to enable | `list(string)` | `[]` | no |
| `disabled_controls` | Map of security standards to controls to disable with optional custom reasons | `map(list(object({control_id=string,reason=optional(string)})))` | `{}` | no |
| `default_disabled_reason` | Default reason to use when disabling controls if no specific reason is provided | `string` | `"Disabled through Terraform"` | no |
| `tags` | Tags to be applied to all resources created by this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `security_hub_account` | The AWS Security Hub account resource |
| `enabled_standards` | List of enabled security standard subscriptions |
| `disabled_controls` | List of disabled security controls |

## Examples

This module includes a variety of examples demonstrating different use cases:

- `basic` - Simple Security Hub enablement with default settings
- `complete` - Comprehensive example with multiple standards and disabled controls

See the [examples](./examples) directory for more information.

## Limitations

For a list of known limitations and constraints, see the [Limitations document](./docs/limitations.md).

## Development

See the `.task` folder for a breakdown of implementation tasks, including requirements, module structure, enabling Security Hub, enabling/disabling rulesets and controls, testing, documentation, and release preparation.

For development, testing, and contributing to this module, please see:
- [Contributing guidelines](./CONTRIBUTING.md)
- [Release process](./docs/release-process.md)

## Release Process

This module uses GitHub Actions for automated releases. When changes are pushed to the main branch:
1. The version is extracted from CHANGELOG.md
2. A Git tag is created
3. A GitHub Release is created

For more details, see the [Release Process documentation](./docs/release-process.md).

## License

See [LICENSE](LICENSE).
