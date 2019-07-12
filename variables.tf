variable "vpc_id" {
  description = "VPC ID"
  default     = ""
}

variable "bucket_name_prefix" {
  description = "S3 Bucket Name Prefix"
  default     = "S3 Bucket for Terraform Remote State Storage"
}

variable "bucket_region" {
  description = "S3 Bucket Region"
  default     = ""
}

variable "tags" {
  description = "Tags To Apply To Created Resources"
  default     = {}
}
