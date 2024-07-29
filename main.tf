#
# Enable VPC flow logs for all traffic.
#
resource "aws_flow_log" "this" {
  log_destination      = aws_s3_bucket.this.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  log_format           = var.log_format
  vpc_id               = var.vpc_id
}

#
# Bucket to store VPC flow logs.
#
resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name_prefix}-vpc-flowlogs"

  tags = var.tags

  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
# Versioning will not be needed for this
resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning
  }
}

# Enable encryption at rest
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

# Enable lifecycle:
#   - After 30 days, data is moved to Standard Infrequent Access
#   - After 60 days, data is expired
resource "aws_s3_bucket_lifecycle_configuration" "default" {
  bucket = aws_s3_bucket.this.id
  rule {
    id     = "vpc-flow-log-rule-1"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 60
    }
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# New
resource "aws_s3_bucket_policy" "this" {
  count = var.enable_default_policy ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.combined[0].json
}

data "aws_iam_policy_document" "combined" {
  count = var.enable_default_policy ? 1 : 0

  source_policy_documents = compact([
    var.enforce_ssl ? data.aws_iam_policy_document.ssl_enforce[0].json : "",
    var.enable_vpc_delivery_service ? data.aws_iam_policy_document.allow_vpc_flowlogs_delivery_service[0].json : "",
    var.custom_policy != null ? var.custom_policy : ""
  ])
}

data "aws_iam_policy_document" "ssl_enforce" {

  count = var.enforce_ssl ? 1 : 0

  statement {
    sid = "EnforceSSlRequestsOnly"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false",
      ]
    }
  }
}

data "aws_iam_policy_document" "allow_vpc_flowlogs_delivery_service" {

  count = var.enable_vpc_delivery_service ? 1 : 0

  statement {
    sid = "AllowVpcFlowLogsDeliveryService"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*",
    ]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}
