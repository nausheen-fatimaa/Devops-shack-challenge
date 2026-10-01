output "alb_dns_name" { value=aws_lb.this.dns_name }
output "asg_name" { value=aws_autoscaling_group.app.name }
output "rds_endpoint" { value=aws_db_instance.db.address }
output "db_password" { value=random_password.db.result sensitive=true }
