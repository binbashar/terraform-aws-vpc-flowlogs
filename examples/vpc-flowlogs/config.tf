#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  version = ">= 4.9"
  region  = var.region
  profile = var.profile
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "region_secondary" {
  type        = string
  description = "AWS secondary Region the S3 replication bucket should reside in"
  default     = "us-east-2"
}

variable "profile" {
  description = "AWS Profile"
  default     = "bb-dev-deploymaster"
}

# Uncomment for local testing
//variable "profile" {
//  type        = string
//  description = "AWS Profile"
//  default     = "bb-apps-devstg-devops"
//}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.28"
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
