# Complete AWS Security Hub Module Example

This example demonstrates how to use the AWS Security Hub Terraform module with various configuration options.

## Usage

```bash
terraform init
terraform apply
```

## Features Demonstrated

1. Enabling AWS Security Hub
2. Subscribing to multiple security standards:
   - AWS Foundational Security Best Practices
   - CIS AWS Foundations Benchmark
   - PCI DSS
3. Disabling specific controls within standards
4. Adding custom tags to resources

## Notes

- You must have appropriate permissions to enable Security Hub in your AWS account.
- Some controls may require specific AWS services to be configured correctly.
- Disabling security controls should be done with careful consideration and proper documentation.
