provider "aws" {
  region = "us-west-2"
}

module "security_hub" {
  source = "../../"

  enabled = true

  # Enable specific security standards
  enable_standards = [
    "aws-foundational-security-best-practices",
    "cis-aws-foundations-benchmark",
    "pci-dss"
  ]

  # Disable specific controls within standards with custom reasons
  disabled_controls = {
    "aws-foundational-security-best-practices" = [
      {
        control_id = "IAM.1"
        reason     = "Root account is required for specific automation tasks"
      },
      {
        control_id = "EC2.10"
        reason     = "Using alternative VPC architecture without endpoints"
      }
    ],
    "cis-aws-foundations-benchmark" = [
      {
        control_id = "1.6"
        reason     = "Using SSO instead of IAM users"
      },
      {
        control_id = "2.7"
        reason     = "Using alternative encryption mechanism for CloudTrail logs"
      }
    ]
  }

  # Optional: Override the default disabled reason
  default_disabled_reason = "Disabled as per security policy v2.1"

  # Add custom tags
  tags = {
    Environment = "example"
    Project     = "security-compliance"
  }
}
