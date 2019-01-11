locals {
  codecommit_repository_name = "${var.codecommit_repository_name == "" ? "cycloid-${var.customer}-servicescatalog" : var.codecommit_repository_name}"
}

resource "aws_codecommit_repository" "repository" {
  count = "${var.create_codecommit_repository ? 1 : 0}"

  repository_name = "${local.codecommit_repository_name}"
  description     = "The stacks and configurations for the ${var.customer} infrastructure"
  default_branch  = "stacks"
}

#
# R/W access for admin
#

# No need for a policy because this user has admin rights

data "aws_iam_user" "admin" {
  count = "${var.create_codecommit_repository ? 1 : 0}"

  user_name = "admin${var.suffix}"
}

resource "aws_iam_user_ssh_key" "admin" {
  count = "${var.create_codecommit_repository ? 1 : 0}"

  username   = "${data.aws_iam_user.admin.user_name}"
  encoding   = "${var.codecommit_key_format}"
  public_key = "${var.codecommit_key_public}"
}

#
# R-O access
#

resource "aws_iam_user" "codecommit_readonly" {
  count = "${var.create_codecommit_repository ? 1 : 0}"

  name = "codecommit-readonly${var.suffix}"
  path = "/cycloid/"
}

resource "aws_iam_user_ssh_key" "codecommit_readonly" {
  count = "${var.create_codecommit_repository ? 1 : 0}"

  username   = "${aws_iam_user.codecommit_readonly.name}"
  encoding   = "${var.codecommit_readonly_key_format}"
  public_key = "${var.codecommit_readonly_key_public}"
}

data "aws_iam_policy_document" "codecommit_readonly" {
  statement {
    actions = [
      "codecommit:BatchGet*",
      "codecommit:Get*",
      "codecommit:Describe*",
      "codecommit:List*",
      "codecommit:GitPull",
    ]

    effect = "Allow"

    resources = [
      "${aws_codecommit_repository.repository.arn}",
    ]
  }
}

resource "aws_iam_user_policy" "codecommit_readonly" {
  count = "${var.create_codecommit_repository ? 1 : 0}"

  name   = "codecommit-stacks-readonly${var.suffix}"
  user   = "${aws_iam_user.codecommit_readonly.name}"
  policy = "${data.aws_iam_policy_document.codecommit_readonly.json}"
}
