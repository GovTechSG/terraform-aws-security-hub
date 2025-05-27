# Required AWS Permissions

To use this module, the AWS account or IAM role running Terraform must have the following permissions:

## Security Hub Permissions

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "securityhub:EnableSecurityHub",
        "securityhub:DisableSecurityHub",
        "securityhub:BatchEnableStandards",
        "securityhub:BatchDisableStandards",
        "securityhub:BatchUpdateStandardsControlAssociations",
        "securityhub:GetEnabledStandards",
        "securityhub:ListSecurityControlDefinitions",
        "securityhub:UpdateStandardsControl",
        "securityhub:DescribeStandardsControls",
        "securityhub:DescribeStandards"
      ],
      "Resource": "*"
    }
  ]
}
```

## Additional Required Permissions

Depending on your AWS environment, you may need these additional permissions:

1. **For AWS Organizations Integration**:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "organizations:DescribeOrganization",
        "organizations:ListAccounts"
      ],
      "Resource": "*"
    }
  ]
}
```

2. **For Cross-Account Configuration**:
If you're using Security Hub delegated administrator features, additional permissions may be required:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "securityhub:CreateMembers",
        "securityhub:DeleteMembers",
        "securityhub:DisassociateMembers",
        "securityhub:EnableOrganizationAdminAccount",
        "securityhub:ListMembers",
        "securityhub:UpdateOrganizationConfiguration"
      ],
      "Resource": "*"
    }
  ]
}
```

## Least Privilege Principle

For production environments, it's recommended to follow the principle of least privilege and restrict the permissions to only what is necessary. The permissions above are the maximum set of permissions that might be needed, but you can tailor them to your specific use case.

## Service-Linked Role

AWS Security Hub creates a service-linked role named `AWSServiceRoleForSecurityHub` with the required permissions to analyze resources in your account. This role is created automatically when you enable Security Hub and does not require any manual setup.

## Permission Dependencies

AWS Security Hub interacts with many other AWS services to check their configurations. While the Security Hub service itself doesn't need permissions to modify these services, it does need permissions to read their configurations. These permissions are handled by the service-linked role.
