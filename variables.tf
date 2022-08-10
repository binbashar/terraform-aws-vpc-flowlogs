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
