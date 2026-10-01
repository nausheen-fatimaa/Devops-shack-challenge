output "vpc_id" {
  value = aws_vpc.main.id
}

output "alb_dns_name" {
  value = aws_lb.web.dns_name
}

output "application_url" {
  value = "http://${aws_lb.web.dns_name}"
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.web.name
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.app.name
}
