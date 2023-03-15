
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
}

resource "aws_iam_user" "terraform_test_user" {
    name = "ben"
    tags = {
        Description = "Legend"
    } 
}