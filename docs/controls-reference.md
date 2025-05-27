# AWS Security Hub Controls Reference

This document provides a reference for Security Hub controls that can be enabled or disabled using this Terraform module.

## AWS Foundational Security Best Practices

| Control ID | Description |
|------------|-------------|
| IAM.1 | IAM policies should restrict full "*:*" administrative privileges |
| IAM.2 | IAM users should not have IAM policies attached |
| IAM.3 | IAM users' access keys should be rotated every 90 days or less |
| IAM.4 | IAM root user access key should not exist |
| EC2.1 | EBS snapshots should not be publicly restorable |
| EC2.2 | VPC Security Groups should not allow ingress from 0.0.0.0/0 to port 22 |
| EC2.3 | Unused EC2 Security Groups should be removed |
| EC2.4 | Security groups should not allow unrestricted access to ports with high risk |
| EC2.6 | VPC flow logging should be enabled in all VPCs |
| EC2.7 | EBS default encryption should be enabled |
| EC2.8 | EC2 instances should use IMDSv2 |
| EC2.10 | Amazon EC2 should be configured to use VPC endpoints |
| S3.1 | S3 Block Public Access setting should be enabled |
| S3.2 | S3 buckets should prohibit public read access |
| S3.3 | S3 buckets should prohibit public write access |
| S3.4 | S3 buckets should have server-side encryption enabled |
| S3.5 | S3 buckets should require requests to use SSL |
| RDS.1 | RDS snapshots should be private |
| RDS.2 | RDS DB instances should prohibit public access |
| RDS.3 | RDS DB instances should have encryption at rest enabled |
| Lambda.1 | Lambda functions should prohibit public access by other accounts |
| Lambda.2 | Lambda functions should use supported runtimes |

This is not a comprehensive list. For the complete list of controls, please refer to the AWS Security Hub documentation.

## CIS AWS Foundations Benchmark

| Control ID | Description |
|------------|-------------|
| 1.1 | Avoid the use of the root account |
| 1.2 | Ensure multi-factor authentication (MFA) is enabled for all IAM users with a console password |
| 1.3 | Ensure credentials unused for 90 days or greater are disabled |
| 1.4 | Ensure access keys are rotated every 90 days or less |
| 1.5 | Ensure IAM password policy requires at least one uppercase letter |
| 1.6 | Ensure IAM password policy requires at least one lowercase letter |
| 1.7 | Ensure IAM password policy requires at least one symbol |
| 1.8 | Ensure IAM password policy requires at least one number |
| 1.9 | Ensure IAM password policy requires minimum password length of 14 or greater |
| 1.10 | Ensure IAM password policy prevents password reuse |
| 1.11 | Ensure IAM password policy expires passwords within 90 days or less |
| 2.1 | Ensure CloudTrail is enabled in all regions |
| 2.2 | Ensure CloudTrail log file validation is enabled |
| 2.3 | Ensure the S3 bucket used to store CloudTrail logs is not publicly accessible |
| 2.4 | Ensure CloudTrail trails are integrated with CloudWatch Logs |
| 2.5 | Ensure AWS Config is enabled in all regions |
| 2.6 | Ensure S3 bucket access logging is enabled on the CloudTrail S3 bucket |
| 2.7 | Ensure CloudTrail logs are encrypted at rest using KMS CMKs |
| 2.8 | Ensure rotation for customer created CMKs is enabled |
| 2.9 | Ensure VPC flow logging is enabled in all VPCs |

This is not a comprehensive list. For the complete list of controls, please refer to the CIS AWS Foundations Benchmark documentation.

## PCI DSS

PCI DSS controls are mapped to various AWS security practices for protecting cardholder data. Each control ID corresponds to a specific requirement in the Payment Card Industry Data Security Standard.

## NIST 800-53

NIST SP 800-53 controls are mapped to various AWS security practices for federal information systems. Each control ID corresponds to a specific requirement in the NIST Special Publication 800-53.

## How to Disable Controls

To disable specific controls, use the `disabled_controls` variable in your module configuration. You can optionally provide a custom reason for each disabled control:

```hcl
module "security_hub" {
  source = "github.com/govtechsg/terraform-aws-security-hub"

  enable_standards = ["aws-foundational-security-best-practices", "cis-aws-foundations-benchmark"]

  # Disable controls with custom reasons
  disabled_controls = {
    "aws-foundational-security-best-practices" = [
      {
        control_id = "IAM.1"
        reason     = "Using alternative IAM configuration"
      },
      {
        control_id = "EC2.10"
        reason     = "Using direct internet access for specific workloads"
      }
    ],
    "cis-aws-foundations-benchmark" = [
      {
        control_id = "1.10"
        reason     = "Using SSO instead of IAM users"
      },
      {
        control_id = "2.7"  # Will use default reason
      }
    ]
  }

  # Optional: Set a default reason for controls without specific reasons
  default_disabled_reason = "Disabled as per security policy v2.1"
}
```

### Custom Disable Reasons

Each disabled control can have:
- A `control_id`: The ID of the control to disable (required)
- A `reason`: A custom reason for disabling the control (optional)

If no reason is provided for a control, the module will use the value from `default_disabled_reason` (defaults to "Disabled through Terraform").

## Best Practices for Disabling Controls

1. **Document your reasons**: Always document why you've chosen to disable a specific control
2. **Regular review**: Periodically review disabled controls to see if they can be re-enabled
3. **Risk assessment**: Perform a risk assessment before disabling any security control
4. **Compensating controls**: If possible, implement compensating controls when disabling a recommended security practice
