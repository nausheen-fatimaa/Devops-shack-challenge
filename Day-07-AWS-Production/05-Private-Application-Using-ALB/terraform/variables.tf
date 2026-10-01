variable "aws_region" { type = string, default = "ap-south-1" }
variable "environment" { type = string, default = "dev" }
variable "vpc_cidr" { type = string, default = "10.50.0.0/16" }
variable "instance_type" { type = string, default = "t3.micro" }
