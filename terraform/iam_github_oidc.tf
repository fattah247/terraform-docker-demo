resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "gha_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:fattah247/terraform-docker-demo:refs/heads/main"]
    }
  }
}

resource "aws_iam_role" "gha_ci" {
  name               = "gha-ci-ecr-role"
  description        = "GitHub Actions CI role for building/pushing to ECR"
  assume_role_policy = data.aws_iam_policy_document.gha_assume_role.json
}

data "aws_iam_policy_document" "ecr_ci" {
  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
      "ecr:BatchGetImage",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_ci" {
  name   = "gha-ci-ecr-policy"
  policy = data.aws_iam_policy_document.ecr_ci.json
}

resource "aws_iam_role_policy_attachment" "gha_ci_attach" {
  role       = aws_iam_role.gha_ci.name
  policy_arn = aws_iam_policy.ecr_ci.arn
}
