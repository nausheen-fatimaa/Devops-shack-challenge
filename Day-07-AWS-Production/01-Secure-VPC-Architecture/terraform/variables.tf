variable "aws_region" {
  description = "AWS region for this lab."
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "enable_nat_gateway" {
  description = "NAT Gateway is required to demonstrate private subnet outbound internet access. It incurs AWS charges."
  type        = bool
  default     = true
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
