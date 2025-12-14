resource "aws_db_subnet_group" "strapi" {
  name       = "strapi-db-subnet-reshma"
  subnet_ids = data.aws_subnets.default.ids
}
resource "aws_db_instance" "strapi" {
  identifier          = "strapi-postgres"
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20

  db_name             = "strapi"
  username            = "strapi"
  password            = var.db_password
  port                = 5432

  publicly_accessible = false
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.rds_sg_reshma.id]
  db_subnet_group_name   = aws_db_subnet_group.strapi.name
}


# resource "aws_db_instance" "strapi" {
#   identifier             = "strapi-postgres"
#   engine                 = "postgres"
#   engine_version         = "15.5"
#   instance_class         = "db.t3.micro"
#   allocated_storage      = 20
#   db_name                = "strapi"
#   username               = "strapi"
#   password               = var.db_password
#   port                   = 5432
#   publicly_accessible    = false
#   skip_final_snapshot    = true

#   vpc_security_group_ids = [aws_security_group.rds_sg_reshma.id]
#   db_subnet_group_name   = aws_db_subnet_group.strapi.name
# }
