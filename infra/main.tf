terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # pin to a stable major version you tested with; adjust if needed:
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.aws_region
}

# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Subnets in the default VPC (replacement for deprecated aws_subnet_ids)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "strapi_sg_reshma" {
  name        = "strapi-sg-reshma"
  description = "Allow SSH HTTP Strapi"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "rds_sg_reshma" {
  name        = "strapi-rds-sg-reshma"
  description = "Allow Postgres from EC2"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.strapi_sg_reshma]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "strapi" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.medium"
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.strapi_sg_reshma]
  associate_public_ip_address = true

  key_name = "strapi-key"

  user_data = templatefile("${path.module}/cloud-init.tpl", {
  image               = var.image
  admin_jwt_secret    = var.admin_jwt_secret
  api_token_salt      = var.api_token_salt
  transfer_token_salt = var.transfer_token_salt
  encryption_key      = var.encryption_key
  app_keys            = var.app_keys
  admin_auth_secret   = var.admin_auth_secret

  db_host     = aws_db_instance.strapi.address
  db_password = var.db_password
})


  tags = {
    Name = "strapi-ec2-reshma"
  }
}

output "public_ip" {
  value = aws_instance.strapi.public_ip
}
