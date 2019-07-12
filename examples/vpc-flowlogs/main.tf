#
# VPC Flow logs module
#
module "vpc_flow_logs" {
    source = "../../"

    vpc_id = "${data.vpc.vpc_id}"
    bucket_name_prefix = "${var.project}-${var.environment}"
    bucket_region = "${var.region}"
    tags = "${local.tags}"
}