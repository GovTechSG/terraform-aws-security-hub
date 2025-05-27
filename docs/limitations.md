# Known Limitations

This document outlines the known limitations of the AWS Security Hub Terraform module.

## Cross-Region Configuration

- The module currently enables Security Hub in a single region. To enable Security Hub in multiple regions, you must call the module multiple times with different providers.
- Example:
  ```hcl
  provider "aws" {
    alias  = "us-east-1"
    region = "us-east-1"
  }

  provider "aws" {
    alias  = "us-west-2"
    region = "us-west-2"
  }

  module "security_hub_us_east_1" {
    source     = "github.com/govtechsg/terraform-aws-security-hub"
    providers  = {
      aws = aws.us-east-1
    }
    # ... other configuration
  }

  module "security_hub_us_west_2" {
    source     = "github.com/govtechsg/terraform-aws-security-hub"
    providers  = {
      aws = aws.us-west-2
    }
    # ... other configuration
  }
  ```

## AWS Organizations Integration

- The current version of the module does not implement full AWS Organizations integration features for Security Hub (such as delegated administrator configuration).
- Manual configuration or custom Terraform code is needed to set up a delegated administrator and manage organization-wide settings.

## Control State Management

- When disabling controls, AWS may re-enable them during certain events such as security standard updates.
- The module will attempt to maintain the desired state, but you may need to run Terraform apply again after AWS updates to ensure controls remain in the desired state.

## Terraform State Refresh

- Due to the asynchronous nature of the AWS Security Hub API, it may take some time for changes to propagate. Terraform may report successful changes before they are fully applied in AWS.
- If you need to immediately validate the changes, you might need to wait a few minutes after applying and then run `terraform refresh` to get the current state.

## Custom Security Standards

- The module does not currently support custom security standards.
- Only the pre-defined AWS standards (AWS FSBP, CIS, PCI DSS, NIST) are supported.

## Finding Management

- This module focuses on standard and control management, not on individual finding management.
- For managing individual findings, you'll need to use the AWS console, CLI, or SDK directly.

## Control ID Mapping

- Some security controls may change over time as AWS updates the standards.
- Always refer to the most recent AWS Security Hub documentation for the current list of available controls.

## State Drift

- Manual changes to Security Hub configuration via the AWS console or API will cause state drift.
- Always make changes through Terraform to ensure the state is properly managed.
