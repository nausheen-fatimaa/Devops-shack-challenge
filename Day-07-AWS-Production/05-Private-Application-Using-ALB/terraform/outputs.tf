output "alb_dns_name" {
  description = "Public DNS name of the ALB."
  value       = aws_lb.this.dns_name
}

output "private_instance_ids" {
  description = "IDs of application instances in private subnets."
  value       = aws_instance.app[*].id
}

output "private_instance_private_ips" {
  description = "Private IP addresses of application instances."
  value       = aws_instance.app[*].private_ip
}
