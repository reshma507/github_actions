resource "aws_ecr_repository" "strapi-reshma" {
  name = "strapi-app-reshma"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.strapi.repository_url
}
