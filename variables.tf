variable "enabled" {
  description = "Whether to enable AWS Security Hub"
  type        = bool
  default     = true
}

variable "enable_standards" {
  description = "List of security standards to enable. Available options: aws-foundational-security-best-practices, cis-aws-foundations-benchmark, pci-dss"
  type        = list(string)
  default     = []
  
  validation {
    condition = alltrue([
      for standard in var.enable_standards :
      contains([
        "aws-foundational-security-best-practices",
        "cis-aws-foundations-benchmark",
        "pci-dss",
        "pci-dss-v4.0.1",
        "nist-800-53",
        "cis-aws-foundations-benchmark-v1.2.0",
        "cis-aws-foundations-benchmark-v1.4.0",
        "cis-aws-foundations-benchmark-v3.0.0",
      ], standard)
    ])
    error_message = "Valid values for enable_standards are: aws-foundational-security-best-practices, cis-aws-foundations-benchmark, pci-dss, nist-800-53, cis-aws-foundations-benchmark-v1.2.0, or cis-aws-foundations-benchmark-v1.4.0."
  }
}

variable "disabled_controls" {
  description = "Map of security standards to list of controls to disable"
  type        = map(list(string))
  default     = {}
  
  # Example:
  # {
  #   "aws-foundational-security-best-practices" = ["IAM.1", "EC2.1"]
  #   "cis-aws-foundations-benchmark" = ["1.1", "1.2"]
  # }
}

variable "tags" {
  description = "Tags to be applied to all resources created by this module"
  type        = map(string)
  default     = {}
}
