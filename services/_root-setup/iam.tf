resource "aws_iam_user" "terraform_user" {
  name = "svc-terraform"
  path = "/"
  tags = local.standard_tags
}

data "aws_iam_policy_document" "terraform_policy" {
  statement {
    sid    = "ListBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}",
    ]
  }

  statement {
    sid    = "AccessBucket"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*",
    ]
  }

  statement {
    sid    = "AccessDynamodb"
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      "${aws_dynamodb_table.terraform_state_lock.arn}",
    ]
  }
}

resource "aws_iam_user_policy" "terraform_user_policy" {
  name   = "terraform_user_policy"
  user   = aws_iam_user.terraform_user.name
  policy = data.aws_iam_policy_document.terraform_policy.json
}
