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
  default     = "bb-ve-shared"
}


#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.13"
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
    bucket  = "ve-shared-terraform-backend"
    key     = "shared/network/terraform.tfstate"
  }
}

#=============================#
# Project Variables           #
#=============================#
variable "environment" {
  description = "Environment Name"
  default     = "shared"
}

variable "project" {
  description = "Environment Name"
  default     = "ve"
}

