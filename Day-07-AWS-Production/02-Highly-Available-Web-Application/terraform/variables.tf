variable "aws_region" { type = string, default = "ap-south-1" }
variable "environment" { type = string, default = "dev" }
variable "vpc_cidr" { type = string, default = "10.20.0.0/16" }
variable "instance_type" { type = string, default = "t3.micro" }
variable "enable_nat_gateway" {
  type = bool
  default = true
  description = "Required because app instances are private and need outbound access."
}
