# Security Controls Reference

This document provides a reference for the security controls available in each standard.

## Control Naming Format

All AWS Security Hub standards now use a consistent control naming format:

- Format: `[Service].[Number]`
- Examples: 
  - `IAM.1` (AWS Foundational Security Best Practices)
  - `IAM.6` (CIS AWS Foundations Benchmark)
  - `EC2.2` (PCI DSS)

This unified naming convention applies to:
- AWS Foundational Security Best Practices
- CIS AWS Foundations Benchmark
- PCI DSS
- All other security standards

## Common Controls to Disable

Below are some commonly disabled controls that might cause issues or may need special handling. Note that all standards now use the service-based naming format (e.g., `IAM.6`, `EC2.1`):

### AWS Foundational Security Best Practices

| Control ID | Description | Reason for Disabling |
|------------|-------------|----------------------|
| `IAM.1` | IAM root user access key should not exist | May be required for some automation or scripts |
| `EC2.10` | EC2 should be configured to use VPC endpoints | May not be applicable in all architectures |
| `CloudTrail.5` | AWS Config should be enabled | If using alternative compliance tooling |
| `S3.13` | S3 buckets should have lifecycle configurations | May not be applicable for certain data |

### CIS AWS Foundations Benchmark

| Control ID | Description | Reason for Disabling |
|------------|-------------|----------------------|
| `IAM.6` | Ensure IAM password policy prevents password reuse | If using SSO or other auth mechanisms |
| `CloudTrail.2` | Ensure CloudTrail logs are encrypted at rest using KMS | If using alternative encryption methods |
| `CloudTrail.1` | Ensure CloudTrail is enabled in all regions | If deliberately restricting to specific regions |
| `VPC.1` | Ensure VPC flow logging is enabled in all VPCs | Performance or cost considerations |

### PCI DSS

| Control ID | Description | Reason for Disabling |
|------------|-------------|----------------------|
| `IAM.7` | IAM policies should not allow full "*:*" administrative privileges | For specific admin roles |
| `EC2.2` | VPC default security group should prohibit inbound and outbound traffic | For specific testing environments |
| `Lambda.1` | Lambda functions should prohibit public access | For public API endpoints |

## How to Disable Controls

To disable specific controls, use the `disabled_controls` variable in the module configuration:

```hcl
module "security_hub" {
  source = "github.com/govtechsg/terraform-aws-security-hub"

  enable_standards = [
    "aws-foundational-security-best-practices",
    "cis-aws-foundations-benchmark"
  ]

  disabled_controls = {
    "aws-foundational-security-best-practices" = ["IAM.1", "EC2.10"]
    "cis-aws-foundations-benchmark" = ["IAM.6", "CloudTrail.2"]
  }
}
```
