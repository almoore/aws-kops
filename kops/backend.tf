// shared/backend.tf
terraform {
  backend "s3" {
    bucket  = "terraform-tfstate-data"
    key     = "aws-kops/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}