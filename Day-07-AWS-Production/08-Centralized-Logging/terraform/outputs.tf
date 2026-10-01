output "flow_log_group" { value=aws_cloudwatch_log_group.flow.name }
output "application_log_group" { value=aws_cloudwatch_log_group.app.name }
output "instance_id" { value=aws_instance.app.id }
