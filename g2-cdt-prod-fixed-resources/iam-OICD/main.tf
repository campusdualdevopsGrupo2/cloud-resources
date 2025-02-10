resource "aws_iam_role" "github_actions_oidc_role" {
  name = "GitHubActionsOIDCRole-grupo-dos"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Federated = "arn:aws:iam::248189943700:oidc-provider/token.actions.githubusercontent.com"
        },
        Action    = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          },
          "ForAnyValue:StringEquals": {
            "token.actions.githubusercontent.com:sub": [
              "repo:campusdualdevopsGrupo2/infra-resources:ref:refs/heads/main",
              "repo:campusdualdevopsGrupo2/app-code:ref:refs/heads/main",
              "repo:campusdualdevopsGrupo2/cloud-resources:ref:refs/heads/main"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "github_actions_policy" {
  name = "GitHubActionsPolicy"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::practica-s3-con-politica-de-retencion",
          "arn:aws:s3:::practica-s3-con-politica-de-retencion/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.github_actions_oidc_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}

terraform {
  backend "s3" {
    bucket  = "proyecto-devops-grupo-dos"          # Nombre de tu bucket S3 para almacenar el estado
    key     = "iam/terraform.tfstate"
    region  = "eu-west-2"                           # Región donde está tu bucket S3
    encrypt = true                                  # Habilita el cifrado en el bucket
  }
}

