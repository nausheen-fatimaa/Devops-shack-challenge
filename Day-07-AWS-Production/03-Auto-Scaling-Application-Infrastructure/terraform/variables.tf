variable "aws_region" { type = string, default = "ap-south-1" }
variable "environment" { type = string, default = "dev" }
variable "vpc_cidr" { type = string, default = "10.30.0.0/16" }
variable "instance_type" { type = string, default = "t3.micro" }
variable "min_size" { type = number, default = 2 }
variable "desired_capacity" { type = number, default = 2 }
variable "max_size" { type = number, default = 4 }
