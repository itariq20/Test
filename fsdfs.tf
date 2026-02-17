resource "aws_iam_user" "user" {
  name          = "${local.resource_prefix.value}-user"
  force_destroy = true

  tags = merge({
    Name        = "${local.resource_prefix.value}-user"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "6988acb171ee05bcde2d8b178440a6e7fc52dcfd"
    git_file             = "fsdfs.tf"
    git_last_modified_at = "2026-02-10 01:05:44"
    git_last_modified_by = "31933916+itariq20@users.noreply.github.com"
    git_modifiers        = "31933916+itariq20"
    git_org              = "itariq20"
    git_repo             = "Test"
    yor_trace            = "9b45b298-c1ea-426a-9644-610780021eaa"
    }, {
    yor_name = "user"
  })

}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "userpolicy" {
  name = "excess_policy"
  user = "${aws_iam_user.user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*",
        "s3:*",
        "lambda:*",
        "cloudwatch:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "username" {
  value = aws_iam_user.user.name
}

output "secret" {
  value = aws_iam_access_key.user.encrypted_secret
}
