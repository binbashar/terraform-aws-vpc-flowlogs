#
# Enable VPC flow logs for all traffic.
#
resource "aws_flow_log" "this" {
  log_destination      = "${aws_s3_bucket.this.arn}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = "${var.vpc_id}"
}

#
# Bucket to store VPC flow logs.
#
resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name_prefix}-vpc-flowlogs"
  acl    = "private"
  region = "${var.bucket_region}"

  # Versioning will not be needed for this
  versioning {
    enabled = false
  }

  # Enable encryption at rest
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable lifecycle:
  #   - After 30 days, data is moved to Standard Infrequent Access
  #   - After 60 days, data is expired
  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 60
    }
  }

  tags = "${var.tags}"
}
