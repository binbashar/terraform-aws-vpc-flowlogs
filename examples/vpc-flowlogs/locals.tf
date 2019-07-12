locals {
  tags = {
    Name        = "infra-jenkinsvault-test"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
