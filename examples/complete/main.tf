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

  # Disable specific controls within standards
  disabled_controls = {
    "aws-foundational-security-best-practices" = [
      "IAM.1",    # IAM root user access key should not exist
      "EC2.10",   # EC2 should be configured to use VPC endpoints
    ]
    "cis-aws-foundations-benchmark" = [
      "IAM.6",        # Ensure IAM password policy prevents password reuse
      "CloudTrail.2"  # Ensure CloudTrail logs are encrypted at rest using KMS CMKs
    ]
  }

  # Add custom tags
  tags = {
    Environment = "example"
    Project     = "security-compliance"
  }
}
