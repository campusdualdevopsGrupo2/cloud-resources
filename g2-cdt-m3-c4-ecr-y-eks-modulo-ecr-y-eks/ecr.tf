resource "aws_ecr_repository" "repository" {
  name = var.repository_name

  tags = var.tags
}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
    sid    = var.policy_sid
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.policy_principals
    }

    actions = var.policy_actions
  }
}

resource "aws_ecr_repository_policy" "repository_policy" {
  repository = aws_ecr_repository.repository.name
  policy     = data.aws_iam_policy_document.ecr_policy.json
}

