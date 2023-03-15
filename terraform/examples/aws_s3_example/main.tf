provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
}

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "terraform-test-bucket-bpw"
  tags = {
    Description = "Bucket created by terraform"
  }
}

resource "aws_s3_bucket_object" "add_object" {
  content = "./main.tf"
  key     = "main.tf"
  bucket  = aws_s3_bucket.terraform_bucket.id
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.terraform_bucket.arn,
      "${aws_s3_bucket.terraform_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.terraform_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}