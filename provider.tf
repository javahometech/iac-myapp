provider "aws" {
  region    = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "javahome2020-tf-july"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
