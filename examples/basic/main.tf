provider "aws" {
  region = "us-west-2"
}

module "security_hub" {
  source = "../../"

  # Enable Security Hub with AWS Foundational Security Best Practices
  enabled = true
  enable_standards = ["aws-foundational-security-best-practices"]
}
