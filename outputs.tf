############################
# AWS Security Hub - Outputs
############################

output "enabled_standards" {
  description = "List of enabled security standard subscriptions"
  value       = var.enabled ? [for s in aws_securityhub_standards_subscription.standards : s.standards_arn] : []
}

output "disabled_controls" {
  description = "List of disabled security controls"
  value       = var.enabled ? [for c in aws_securityhub_standards_control.disabled_controls : c.standards_control_arn] : []
}
