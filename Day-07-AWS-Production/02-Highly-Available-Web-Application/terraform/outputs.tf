output "alb_dns_name" { value = aws_lb.this.dns_name }
output "vpc_id" { value = aws_vpc.this.id }
output "instance_ids" { value = aws_instance.app[*].id }
