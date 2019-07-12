#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  default     = "aws-shared-profile"
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.11.14"
}

#=============================#
# Data sources                #
#=============================#
variable "region_backend_data" {
  description = "AWS Region"
  default     = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    region  = "${var.region_backend_data}"
    profile = "${var.profile}"
    bucket  = "demo-shared-terraform-state-storage-s3"
    key     = "shared/network/terraform.tfstate"
  }
}

#=============================#
# Project Variables           #
#=============================#
variable "environment" {
  description = "Environment Name"
  default     = "dev"
}

variable "project" {
  description = "Environment Name"
  default     = "demo"
}
