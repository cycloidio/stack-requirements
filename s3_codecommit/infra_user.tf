resource "aws_iam_user" "infra" {
  count = "${var.create_infra_user ? 1 : 0}"

  name = "infra${var.suffix}"
  path = "/cycloid/"
}

resource "aws_iam_access_key" "infra" {
  count = "${var.create_infra_user ? 1 : 0}"

  user = "${aws_iam_user.infra.name}"
}

resource "aws_iam_policy_attachment" "infra_administrator_access" {
  count = "${var.create_infra_user ? 1 : 0}"

  name       = "infra-AdministratorAccess${var.suffix}"
  users      = ["${aws_iam_user.infra.name}"]
  roles      = ["admin"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  lifecycle {
    ignore_changes = [
      "groups",
    ]
  }
}
