variable "aws_region" {
  default = "eu-north-1"
}

variable "ec2_instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  default = "strapi-key"
}

variable "dockerhub_username" {
  type = string
}
variable "dockerhub_token" {
  type = string
}

variable "image_name" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_allocated_storage" {
  default = 20
}

# variable "dockerhub_username" {}
# variable "dockerhub_password" {}
# variable "image_name" {
#   default = "strapi-terraform"
# }
# variable "aws_region" {
#   type    = string
#   default = "eu-north-1"
# }


# variable "ec2_instance_type" {
#   type    = string
#   default = "t3.micro"
# }

# variable "key_name" {
#   type        = string
#   description = "Existing AWS key pair name for SSH (leave blank to skip)"
#   default     = "strapi-key"
# }

# variable "ssh_private_key_path" {
#   type = string
#   description = "Path to private key for Terraform remote-exec (optional)"
#   default = ""
# }

# variable "db_name" {
#   type    = string
#   default = "strapi_db"
# }

# variable "db_username" {
#   type    = string
#   default = "strapi_user"
# }

# variable "db_password" {
#   type        = string
#   description = "Postgres DB password (sensitive)"
#   sensitive   = true
#   default     = "strapi_pass"
# }

# variable "db_allocated_storage" {
#   type    = number
#   default = 20
# }
# variable "image_tag" {
#   type    = string
#   default = "latest"
# }
