<div align="center">
    <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-vpc-flowlogs/master/figures/binbash.png"
     alt="drawing" width="250"/>
</div>
<div align="right">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-vpc-flowlogs/master/figures/binbash-leverage-terraform.png"
   alt="leverage" width="130"/>
</div>

# Terraform Module: VPC Flow Logs

A Terraform module for enabling VPC Flow Logs to an S3 bucket.

## Releases
- **Versions:** `<= 0.x.y` (Terraform 0.11.x compatible)
    - eg: https://registry.terraform.io/modules/binbashar/vpc-flow-logs/aws/0.0.1

- **Versions:** `>= 1.x.y` (Terraform 0.12.x compatible)
    - eg: https://registry.terraform.io/modules/binbashar/vpc-flow-logs/aws/1.0.0

- **TODO:** Support AWS Org centralized flow logs -> https://aws.amazon.com/blogs/security/how-to-facilitate-data-analysis-and-fulfill-security-requirements-by-using-centralized-flow-log-data/

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.28 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_prefix"></a> [bucket\_name\_prefix](#input\_bucket\_name\_prefix) | S3 Bucket Name Prefix | `string` | `"S3 Bucket for Terraform Remote State Storage"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags To Apply To Created Resources | `map` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | S3 Bucket ARN |
| <a name="output_flow_log_id"></a> [flow\_log\_id](#output\_flow\_log\_id) | Flow Log ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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

---

## Binbash Leverage | DevOps Automation Code Library Integration

In order to get the full automated potential of the
[Binbash Leverage DevOps Automation Code Library](https://leverage.binbash.com.ar/how-it-works/code-library/code-library/)  
you should initialize all the necessary helper **Makefiles**.

#### How?
You must execute the `make init-makefiles` command  at the root context

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - init-makefiles     initialize makefiles

```

### Why?
You'll get all the necessary commands to automatically operate this module via a dockerized approach,
example shown below

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - circleci-validate-config  ## Validate A CircleCI Config (https
 - format-check        ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - format              ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - tf-dir-chmod        ## run chown in ./.terraform to gran that the docker mounted dir has the right permissions
 - version             ## Show terraform version
 - init-makefiles      ## initialize makefiles
```

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make format-check
docker run --rm -v /home/delivery/Binbash/repos/Leverage/terraform/terraform-aws-backup-by-tags:"/go/src/project/":rw -v :/config -v /common.config:/common-config/common.config -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig -v ~/.aws/bb:/root/.aws/bb -e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/bb/credentials -e AWS_CONFIG_FILE=/root/.aws/bb/config --entrypoint=/bin/terraform -w "/go/src/project/" -it binbash/terraform-awscli-slim:0.12.28 fmt -check
```

# Release Management

### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-vpc-flowlogs/master/figures/circleci.png"
   alt="leverage-circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-vpc-flowlogs) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-vpc-flowlogs/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-vpc-flowlogs/blob/master/CHANGELOG.md)

