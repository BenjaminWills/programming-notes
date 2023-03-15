
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
}

resource "aws_iam_user" "terraform_test_user" {
  name = "ben"
  tags = {
    Description = "Legend"
  }
}

data "aws_iam_policy_document" "test_policy" {
  statement {
    actions = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "terraform_test_user_policy" {
  name = "terraform_test_user_policy"
  policy = "${data.aws_iam_policy_document.test_policy.json}"
}

resource "aws_iam_policy_attachment" "terraform_test_user_policy_attatchment" {
  name = "test-attatchment"

  users = [aws_iam_user.terraform_test_user.name]

  policy_arn = aws_iam_policy.terraform_test_user_policy.arn

}