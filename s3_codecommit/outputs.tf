output "codecommit_username" {
  value = "${aws_iam_user_ssh_key.admin.*.ssh_public_key_id}"
}

output "codecommit_readonly_username" {
  value = "${aws_iam_user_ssh_key.codecommit_readonly.*.ssh_public_key_id}"
}

output "remote_state_bucket_name" {
  value = "${aws_s3_bucket.terraform_remote_state.id}"
}
