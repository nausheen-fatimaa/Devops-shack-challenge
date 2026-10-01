variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name used for the remote state bootstrap."
  type        = string
}

variable "state_bucket_region" {
  type    = string
  default = "ap-south-1"
}
