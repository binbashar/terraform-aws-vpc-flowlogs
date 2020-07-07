#=============================#
# AWS Provider Settings       #
#=============================#
//provider "aws" {
//  region  = var.region
//  profile = var.profile
//}

provider "aws" {
  version                 = "~> 2.63"
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = "~/.aws/bb-le/config"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

//variable "profile" {
//  description = "AWS Profile"
//  default     = "bb-dev-deploymaster"
//}

variable "profile" {
  description = "AWS Profile"
  default     = "bb-apps-devstg-devops"
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.28"
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
    bucket  = "bb-apps-devstg-terraform-backend"
    key     = "apps-devstg/network/terraform.tfstate"
  }
}