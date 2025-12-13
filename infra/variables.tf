variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "image" {
  type = string
}
variable "admin_jwt_secret" {
  type      = string
  sensitive = true
}

variable "api_token_salt" {
  type      = string
  sensitive = true
}

variable "transfer_token_salt" {
  type      = string
  sensitive = true
}

variable "encryption_key" {
  type      = string
  sensitive = true
}
variable "app_keys" {
  type      = string
  sensitive = true
}
variable "encryption_key"{
  type     = string
  sensitive = true
}
variable "admin_auth_secret"{
  type     = string
  sensitive = true
}
