<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-iam-role-sts/master/figures/binbash.png" alt="drawing" width="350"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-iam-role-sts/master/figures/binbash-leverage-terraform.png" alt="leverage" width="230"/>
</div>

# Terraform Module: VPC Flow Logs

A Terraform module for enabling VPC Flow Logs to an S3 bucket.

## Releases
- **Versions:** `<= 0.x.y` (Terraform 0.11.x compatible)
    - eg: https://registry.terraform.io/modules/binbashar/iam-role-sts/aws/0.0.1

- **Versions:** `>= 1.x.y` (Terraform 0.12.x compatible -> **WIP**)
    - eg: https://registry.terraform.io/modules/binbashar/iam-role-sts/aws/1.0.0

- **TODO:** Support AWS Org centralized flow logs -> https://aws.amazon.com/blogs/security/how-to-facilitate-data-analysis-and-fulfill-security-requirements-by-using-centralized-flow-log-data/

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket\_name\_prefix | S3 Bucket Name Prefix | string | `"S3 Bucket for Terraform Remote State Storage"` | no |
| bucket\_region | S3 Bucket Region | string | `""` | no |
| tags | Tags To Apply To Created Resources | map | `<map>` | no |
| vpc\_id | VPC ID | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | S3 Bucket ARN |
| flow\_log\_id | Flow Log ID |

## Examples
### VPC Flow Logs
```terraform
#
# VPC Flow Logs
#
module "vpc_flow_logs" {
    source = "git::git@github.com:binbashar/terraform-aws-vpc-flowlogs.git?ref=v0.0.2"

    vpc_id = "your-vpc-id"
    bucket_name_prefix = "your-s3-bucket-name-prefix"
    bucket_region = "your-s3-bucket-region"
    tags = "your-tags"
}
```