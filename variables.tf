variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}

variable "bucket_name_prefix" {
  description = "S3 Bucket Name Prefix"
  type        = string
  default     = "S3 Bucket for Terraform Remote State Storage"
}

variable "log_format" {
  description = "VPC Flow Logs Format"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags To Apply To Created Resources"
  type        = any
  default     = {}
}

variable "force_destroy" {
  description = "Whether to forcefully destroy the bucket or not"
  type        = bool
  default     = false
}

variable "enforce_ssl" {
  description = "Enforce bucket SSL encryption"
  type        = bool
  default     = true
}

variable "enable_vpc_delivery_service" {
  description = "Enable VPC delivery service policy"
  type        = bool
  default     = true
}

variable "custom_policy" {
  description = "Custom policy"
  type        = string
  default     = null
}

variable "enable_default_policy" {
  description = "Enable default policy"
  type        = bool
  default     = true
}

variable "enable_versioning" {
  description = "Enable bucket versioning"
  type        = string
  default     = "Disabled"
  validation {
    condition     = can(regex("^(Enabled|Disabled|Suspended)$", var.enable_versioning))
    error_message = "Wrong state. Available only: Enabled, Disabled or Suspended"
  }
}

variable "sse_algorithm" {
  description = "Server-side encryption algorythm"
  type        = string
  default     = "AES256"
  validation {
    condition     = can(regex("^(AES256|aws:kms)$", var.sse_algorithm))
    error_message = "Wrong SSE algorythm. Available only: AES256 or aws:kms"
  }
}
