locals {
  tags = {
    Name        = "infra-vpc-flow-logs-test"
    Terraform   = "true"
    Environment = var.environment
  }
}
