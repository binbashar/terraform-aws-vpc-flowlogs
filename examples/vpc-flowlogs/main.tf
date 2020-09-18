#
# Define some input just to show how variables can be passed from the test.
#
#variable "countries" {
#    description = "Countries"
#    default     = "AR,BR,CH"
#}

#
# Instantiate the module.
#
#module "backend" {
#    source      = "../../"
#
#    countries   = "${var.countries}"
#}

#
# Output the module's output for verification.
#
#output "countries" {
#    value = "${module.sample.countries}"
#}

#=================#
# VPC FLOW LOGS   #
#=================#
module "vpc_flow_logs_test" {
  source = "../../"

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  bucket_name_prefix = "${var.project}-${var.environment}"
  tags               = local.tags
}
