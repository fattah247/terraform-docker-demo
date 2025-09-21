resource "aws_ecr_lifecycle_policy" "keep_small" {
  repository = aws_ecr_repository.app.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 5 images, expire older",
        selection = {
          tagStatus   = "any",
          countType   = "imageCountMoreThan",
          countNumber = 5
        },
        action = { type = "expire" }
      }
    ]
  })
}
