variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "image" {
  type = string
}
variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}
