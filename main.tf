############################
# AWS Security Hub - Main
############################

# This map provides lookup for standard ARNs
locals {
  # Standard ARNs and control mapping
  standards_mapping = {
    "aws-foundational-security-best-practices" = "aws-foundational-security-best-practices/v/1.0.0"
    "cis-aws-foundations-benchmark"            = "cis-aws-foundations-benchmark/v/1.4.0"
    "cis-aws-foundations-benchmark-v1.4.0"     = "cis-aws-foundations-benchmark/v/1.4.0"
    "cis-aws-foundations-benchmark-v3.0.0"     = "cis-aws-foundations-benchmark/v/3.0.0"
    "pci-dss"                                  = "pci-dss/v/3.2.1"
    "pci-dss-v4.0.1"                           = "pci-dss/v/4.0.1"
    "nist-800-53"                              = "nist-800-53/v/5.0.0"
  }

  standards_arns = { for k, v in local.standards_mapping :
    k => "arn:aws:securityhub:${data.aws_region.current.name}::standards/${v}"
  }

  # Flatten the disabled_controls map for easier use later
  controls_to_disable = flatten([
    for standard, controls in var.disabled_controls : [
      for control in controls : {
        standard = standard
        control  = control.control_id
        reason   = coalesce(control.reason, var.default_disabled_reason)
      }
    ]
  ])

  enabled_standards = [
    for standard in var.enable_standards : local.standards_arns[standard]
  ]

  # Add default tags to all resources
  default_tags = merge(
    {
      "managed-by" = "terraform"
      "module"     = "terraform-aws-security-hub"
    },
    var.tags
  )
}

# Get current AWS region
data "aws_region" "current" {}

# Get current AWS account ID
data "aws_caller_identity" "current" {}


# Subscribe to security standards
resource "aws_securityhub_standards_subscription" "standards" {
  for_each = var.enabled ? toset(local.enabled_standards) : []

  standards_arn = each.value
}

# Disable specific controls within standards
# The lookup pattern for control ARNs varies by standard
resource "aws_securityhub_standards_control" "disabled_controls" {
  for_each = { for control in local.controls_to_disable :
    "${control.standard}/${control.control}" => control if var.enabled
  }

  standards_control_arn = format(
    "arn:aws:securityhub:%s:%s:control/%s/%s",
    data.aws_region.current.name,
    data.aws_caller_identity.current.account_id,
    local.standards_mapping[each.value.standard],  # This includes the full path with version
    each.value.control
  )
  control_status        = "DISABLED"
  disabled_reason       = each.value.reason

  depends_on = [aws_securityhub_standards_subscription.standards]
}
