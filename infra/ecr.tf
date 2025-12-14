resource "aws_ecr_repository" "strapi" {
  name = "strapi-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.strapi.repository_url
}
