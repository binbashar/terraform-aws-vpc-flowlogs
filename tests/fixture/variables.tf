#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  region  = var.region
  profile = var.profile
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  default     = "bb-dev-deploymaster"
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.13"
}

#=============================#
# Project Variables           #
#=============================#
variable "project" {
  description = "Project id"
  default     = "bb"
}

variable "environment" {
  description = "Environment Name"
  default     = "dev-test"
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

  config = {
    region  = var.region_backend_data
    profile = var.profile
    bucket  = "bb-dev-terraform-state-storage-s3"
    key     = "dev/network/terraform.tfstate"
  }
}