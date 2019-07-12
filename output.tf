output "flow_log_id" {
  value       = "${aws_flow_log.this.id}"
  description = "Flow Log ID"
}

output "bucket_arn" {
  value       = "${aws_s3_bucket.this.arn}"
  description = "S3 Bucket ARN"
}
