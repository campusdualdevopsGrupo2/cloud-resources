resource "aws_ecr_repository" "repository" {
  name = var.repository_name

  tags = {
    Project = "Repositorio-grupo-dos"
  }
}

data "aws_iam_policy_document" "example" {
  statement {
    sid    = "new policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:sts::248189943700:assumed-role/AWSReservedSSO_EKS-alumnos_a4561514b13725b0/jorge.vidal@campusdual.com"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_ecr_repository_policy" "example" {
  repository = aws_ecr_repository.repository.name
  policy     = data.aws_iam_policy_document.example.json
}

