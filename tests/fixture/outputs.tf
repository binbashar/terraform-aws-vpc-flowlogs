#
# WAF
#
output "flow_log_id" {
  value = module.vpc_flow_logs_test.flow_log_id
}

output "bucket_arn" {
  value = module.vpc_flow_logs_test.bucket_arn
}