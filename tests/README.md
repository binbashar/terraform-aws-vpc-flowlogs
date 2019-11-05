# Terraform Module Tests: Terratests

## Overview
Terratest is a Go library that makes it easier to write automated tests for your infrastructure code.
It provides a variety of helper functions and patterns for common infrastructure testing tasks, including:
- Testing Terraform code
- Working with AWS APIs
- And much more

Official **terratest** [documentation available on GitHub project repo](https://github.com/gruntwork-io/terratest).
Ref Article [available on Medium maintainers blog](https://blog.gruntwork.io/open-sourcing-terratest-a-swiss-army-knife-for-testing-infrastructure-code-5d883336fcd5).

### Install requirements

Terratest uses the Go testing framework. To use terratest, you need to install:

- [Go](https://golang.org/) (requires version >=1.10)
- [dep](https://github.com/golang/dep) (requires version >=0.5.1)

## Files Organization
* Terraform files are located at the root of this directory.
* Tests can be found under tests/ directory.

## Testing
### Key Points
* We use `terratest` for testing this module.
* Keep in mind that `terratest` is not a binary but a Go library with helpers that make it easier to work with Terraform and other tools.
* Test files use `_test` suffix. E.g.: `create_file_with_default_values_test.go`
* Test classes use `Test` prefix. E.g.: `func TestCreateFileWithDefaultValues(t *testing.T) {`
* Our tests make use of a fixture/ dir that resembles how the module will be used.

### Set Up

#### Dokerized Makefile
```
$ make
Available Commands:
...
 - terratest-dep-init dep is a dependency management tool for Go. (https://github.com/golang/dep)
 - terratest-go-test  lint: TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
...
```

1.  `make terratest-dep-init`
```
$ make terratest-dep-init
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-ec2-jenkins-vault:"/go/src/project/":rw -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig --entrypoint=dep -it binbash/terraform-resources:0.11.14 init
  Locking in master (da137c7) for transitive dep golang.org/x/net
  Using ^1.3.0 as constraint for direct dep github.com/stretchr/testify
  Locking in v1.3.0 (ffdc059) for direct dep github.com/stretchr/testify
  Locking in v1.0.0 (792786c) for transitive dep github.com/pmezard/go-difflib
  Using ^0.17.5 as constraint for direct dep github.com/gruntwork-io/terratest
  Locking in v0.17.5 (03959c9) for direct dep github.com/gruntwork-io/terratest
  Locking in v1.1.1 (8991bc2) for transitive dep github.com/davecgh/go-spew
  Locking in master (4def268) for transitive dep golang.org/x/crypto
  Locking in master (04f50cd) for transitive dep golang.org/x/sys
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-ec2-jenkins-vault:"/go/src/project/":rw -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig --entrypoint=dep -it binbash/terraform-resources:0.11.14 ensure
sudo chown -R delivery:delivery .
cp -r ./vendor ./tests/ && rm -rf ./vendor
cp -r ./Gopkg* ./tests/ && rm -rf ./Gopkg*
```

2. `terratest-go-test`
```
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: 
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: Outputs:
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: 
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: bucket_arn = arn:aws:s3:::bb-dev-test-vpc-flowlogs
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: flow_log_id = fl-024d9f7d9750903d6
TestAwsWaf 2019-11-05T18:05:12Z retry.go:72: terraform [output -no-color bucket_arn]
TestAwsWaf 2019-11-05T18:05:12Z command.go:87: Running command terraform with args [output -no-color bucket_arn]
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: arn:aws:s3:::bb-dev-test-vpc-flowlogs
TestAwsWaf 2019-11-05T18:05:12Z retry.go:72: terraform [destroy -auto-approve -input=false -lock=false -no-color]
TestAwsWaf 2019-11-05T18:05:12Z command.go:87: Running command terraform with args [destroy -auto-approve -input=false -lock=false -no-color]
TestAwsWaf 2019-11-05T18:05:16Z command.go:158: data.terraform_remote_state.vpc: Refreshing state...
TestAwsWaf 2019-11-05T18:05:18Z command.go:158: module.vpc_flow_logs_test.aws_s3_bucket.this: Refreshing state... [id=bb-dev-test-vpc-flowlogs]
TestAwsWaf 2019-11-05T18:05:29Z command.go:158: module.vpc_flow_logs_test.aws_flow_log.this: Refreshing state... [id=fl-024d9f7d9750903d6]
TestAwsWaf 2019-11-05T18:05:34Z command.go:158: module.vpc_flow_logs_test.aws_flow_log.this: Destroying... [id=fl-024d9f7d9750903d6]
TestAwsWaf 2019-11-05T18:05:35Z command.go:158: module.vpc_flow_logs_test.aws_flow_log.this: Destruction complete after 1s
TestAwsWaf 2019-11-05T18:05:35Z command.go:158: module.vpc_flow_logs_test.aws_s3_bucket.this: Destroying... [id=bb-dev-test-vpc-flowlogs]
TestAwsWaf 2019-11-05T18:05:36Z command.go:158: module.vpc_flow_logs_test.aws_s3_bucket.this: Destruction complete after 1s
TestAwsWaf 2019-11-05T18:05:36Z command.go:158: 
TestAwsWaf 2019-11-05T18:05:36Z command.go:158: Destroy complete! Resources: 2 destroyed.
PASS
ok      project/tests   72.639s
sudo chown -R delivery:delivery .
```

#### Local installed deps execution
* Make sure this module is within the **GOPATH directory**.
    * Default GOPATH is usually set to `$HOME/go` but you can override that permanently or temporarily.
    * For instance, you could place all your modules under `/home/john.doe/project_name/tf-modules/src/`
    * Then you would use `export GOPATH=/home/john.doe/project_name/tf-modules/`
    * Or you could simply place all your modules under `$HOME/go/src/`
* Go to the `tests/` dir and run `dep ensure` to resolve all dependencies.
    * This should create a `vendor/` dir under `tests/` dir and also a `pkg/` dir under the GOPATH dir.
* Now you can run `go test`


### Tests Result: Passing
```
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: 
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: Outputs:
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: 
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: bucket_arn = arn:aws:s3:::bb-dev-test-vpc-flowlogs
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: flow_log_id = fl-024d9f7d9750903d6
TestAwsWaf 2019-11-05T18:05:12Z retry.go:72: terraform [output -no-color bucket_arn]
TestAwsWaf 2019-11-05T18:05:12Z command.go:87: Running command terraform with args [output -no-color bucket_arn]
TestAwsWaf 2019-11-05T18:05:12Z command.go:158: arn:aws:s3:::bb-dev-test-vpc-flowlogs
TestAwsWaf 2019-11-05T18:05:12Z retry.go:72: terraform [destroy -auto-approve -input=false -lock=false -no-color]
TestAwsWaf 2019-11-05T18:05:12Z command.go:87: Running command terraform with args [destroy -auto-approve -input=false -lock=false -no-color]
TestAwsWaf 2019-11-05T18:05:16Z command.go:158: data.terraform_remote_state.vpc: Refreshing state...
TestAwsWaf 2019-11-05T18:05:18Z command.go:158: module.vpc_flow_logs_test.aws_s3_bucket.this: Refreshing state... [id=bb-dev-test-vpc-flowlogs]
TestAwsWaf 2019-11-05T18:05:29Z command.go:158: module.vpc_flow_logs_test.aws_flow_log.this: Refreshing state... [id=fl-024d9f7d9750903d6]
TestAwsWaf 2019-11-05T18:05:34Z command.go:158: module.vpc_flow_logs_test.aws_flow_log.this: Destroying... [id=fl-024d9f7d9750903d6]
TestAwsWaf 2019-11-05T18:05:35Z command.go:158: module.vpc_flow_logs_test.aws_flow_log.this: Destruction complete after 1s
TestAwsWaf 2019-11-05T18:05:35Z command.go:158: module.vpc_flow_logs_test.aws_s3_bucket.this: Destroying... [id=bb-dev-test-vpc-flowlogs]
TestAwsWaf 2019-11-05T18:05:36Z command.go:158: module.vpc_flow_logs_test.aws_s3_bucket.this: Destruction complete after 1s
TestAwsWaf 2019-11-05T18:05:36Z command.go:158: 
TestAwsWaf 2019-11-05T18:05:36Z command.go:158: Destroy complete! Resources: 2 destroyed.
PASS
ok      project/tests   72.639s
sudo chown -R delivery:delivery .
```

## Code Linting & Static Code Analysis

* The `terraform fmt` command is used to rewrite Terraform configuration files to a canonical format and style.
  This command applies a subset of the Terraform language style conventions, along with other minor adjustments for
  readability. (https://www.terraform.io/docs/commands/fmt.html)
* TFLint is a Terraform linter focused on possible errors, best practices, etc. (https://github.com/wata727/tflint)

```
# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy x [15:32:08]
$ make
Available Commands:
 ...
 - format             The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - lint               TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
 ...

# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy o [15:31:47]
$ make format
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget:"/go/src/project/":rw --entrypoint=/usr/local/go/bin/terraform -it binbash/terraform-resources:0.11.14 fmt "/go/src/project/"
/go/src/project/outputs.tf
/go/src/project/sns.tf
/go/src/project/tests/fixture/main.tf
/go/src/project/tests/fixture/outputs.tf
/go/src/project/tests/fixture/variables.tf



# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy x [15:34:45]
$ make lint
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget:/data -t wata727/tflint --deep
Awesome! Your code is following the best practices :)
```