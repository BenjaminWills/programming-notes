terraform {
  backend "s3" {
    bucket = "testbucketbenwills"
    key = "test/terraform.tfstate"
    region = "eu-west-2"
  }
}