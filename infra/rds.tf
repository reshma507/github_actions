resource "aws_db_subnet_group" "strapi" {
  name       = "strapi-db-subnet"
  subnet_ids = data.aws_subnets.default.ids
}

resource "aws_db_instance" "strapi" {
  identifier             = "strapi-postgres"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "strapi"
  username               = "strapi"
  password               = var.db_password
  port                   = 5432
  publicly_accessible    = false
  skip_final_snapshot    = true

  vpc_security_group_ids = [aws_security_group.rds_sg-reshma.id]
  db_subnet_group_name   = aws_db_subnet_group.strapi.name
}
