
terraform {
  required_version = ">= 0.12.28"

  required_providers {
    aws = ">= 3.0, != 4.0, != 4.1, != 4.2, != 4.3, != 4.4, != 4.5, != 4.6, != 4.7, != 4.8"
  }
}
