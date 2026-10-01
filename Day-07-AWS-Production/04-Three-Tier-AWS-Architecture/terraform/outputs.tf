output "alb_dns_name" { value = aws_lb.this.dns_name }
output "vpc_id" { value = aws_vpc.this.id }
output "app_instance_ids" { value = aws_instance.app[*].id }
output "rds_endpoint" { value = aws_db_instance.this.address }
output "rds_port" { value = aws_db_instance.this.port }
