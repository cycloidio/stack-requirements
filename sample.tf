module "s3_codecommit" {
  source = "github.com/cycloidio/stack-requirements//s3_codecommit"

  create_codecommit_repository   = "1"
  create_s3_bucket               = "1"
  create_infra_user              = "1"
  customer                       = "r2d2"
  codecommit_readonly_key_public = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA...3s+KslkalkI198auyP r2d2"
  codecommit_key_public          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQA...90T3s+YwdVVqNzsauyP r2d2"

  # extra possible variables
  # codecommit_repository_name   = "cycloid-r2d2"
  # suffix                       = ""
  # infra_iam_arn                = ""
}

#
# You could use those elements if you wanted to store the data remotely
# Note: it first need to exist - so have run at least once
#
#variable "access_key" {}
#variable "secret_key" {}
#variable "aws_region" {
#  description = "AWS region to launch servers."
#  default     = "eu-west-1"
#}
#
#provider "aws" {
#  access_key = "${var.access_key}"
#  secret_key = "${var.secret_key}"
#  region     = "${var.aws_region}"
#}
#
## Due to current limitations: https://github.com/hashicorp/terraform/issues/13022
## you cannot use variables in the backend configuration, you need to
## set all variables manually rather than using interpolation.
#terraform {
#  backend "s3" {
#    bucket = "<customer-here>-terraform-remote-state"
#    key    = "infrastructure/infra/infrastructure-infra.tfstate"
#    region = "<region-here>"
#  }
#}
#
