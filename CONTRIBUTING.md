# Contributing to the AWS Security Hub Terraform Module

We welcome contributions to this Terraform module. Here are some guidelines to help you get started.

## How to Contribute

1. **Fork the Repository**: Fork the repository to your own GitHub account
2. **Clone the Fork**: Clone your fork locally (`git clone https://github.com/YOUR-USERNAME/terraform-aws-security-hub.git`)
3. **Create a Branch**: Create a branch for your changes (`git checkout -b feature/your-feature-name`)
4. **Make Changes**: Make your changes to the code, adhering to the coding standards
5. **Test**: Test your changes thoroughly
6. **Commit**: Commit your changes with a clear, descriptive message
7. **Push**: Push to your fork (`git push origin feature/your-feature-name`)
8. **Create a Pull Request**: Open a pull request from your fork to the main repository

## Development Requirements

- Terraform 1.0 or later
- AWS CLI configured with appropriate credentials
- Basic knowledge of AWS Security Hub

## Code Standards

- Follow HashiCorp's Terraform style conventions
- Include descriptions for all variables and outputs
- Document all changes in the CHANGELOG.md
- Update documentation to reflect changes

## Testing

Before submitting a pull request, please test your changes:

- Ensure the module can be initialized (`terraform init`)
- Check for syntax errors (`terraform validate`)
- Run the examples to verify functionality

## Documentation

Update documentation to reflect your changes:

- README.md
- docs/ directory
- Example code
- CHANGELOG.md

## Adding New Features

When adding new features:

1. Consider backwards compatibility
2. Document the feature in README.md
3. Add example code
4. Update the CHANGELOG.md

## Reporting Issues

If you find a bug or have a feature request, please open an issue on the GitHub repository.
