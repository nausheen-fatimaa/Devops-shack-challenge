variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "db_password must contain at least 8 characters."
  }
}
