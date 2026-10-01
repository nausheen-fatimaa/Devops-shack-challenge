data "aws_ssm_parameter" "al2023" { name="/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64" }
resource "aws_cloudwatch_log_group" "flow" { name="/day7/vpc-flow-logs" retention_in_days=14 }
resource "aws_cloudwatch_log_group" "app" { name="/day7/application" retention_in_days=14 }
resource "aws_iam_role" "flow" { name="${var.project_name}-flow-role" assume_role_policy=jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Principal={Service="vpc-flow-logs.amazonaws.com"},Action="sts:AssumeRole"}]}) }
resource "aws_iam_role_policy" "flow" { role=aws_iam_role.flow.id policy=jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Action=["logs:CreateLogStream","logs:DescribeLogGroups","logs:DescribeLogStreams","logs:PutLogEvents"],Resource="${aws_cloudwatch_log_group.flow.arn}:*"}]}) }
resource "aws_flow_log" "vpc" { vpc_id=aws_vpc.this.id traffic_type="ALL" iam_role_arn=aws_iam_role.flow.arn log_destination_type="cloud-watch-logs" log_destination=aws_cloudwatch_log_group.flow.arn }
resource "aws_security_group" "app" { name_prefix="${var.project_name}-app-" vpc_id=aws_vpc.this.id ingress {from_port=80 to_port=80 protocol="tcp" cidr_blocks=[aws_vpc.this.cidr_block]} egress {from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"]} }
resource "aws_iam_role" "ec2" { name="${var.project_name}-ec2-role" assume_role_policy=jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Principal={Service="ec2.amazonaws.com"},Action="sts:AssumeRole"}]}) }
resource "aws_iam_role_policy_attachment" "ssm" { role=aws_iam_role.ec2.name policy_arn="arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" }
resource "aws_iam_role_policy" "logs" { role=aws_iam_role.ec2.id policy=jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Action=["logs:CreateLogStream","logs:PutLogEvents","logs:DescribeLogStreams"],Resource="${aws_cloudwatch_log_group.app.arn}:*"}]}) }
resource "aws_iam_instance_profile" "ec2" { name="${var.project_name}-profile" role=aws_iam_role.ec2.name }
resource "aws_instance" "app" { ami=data.aws_ssm_parameter.al2023.value instance_type=var.instance_type subnet_id=aws_subnet.private[0].id vpc_security_group_ids=[aws_security_group.app.id] iam_instance_profile=aws_iam_instance_profile.ec2.name user_data=base64encode(<<-EOF
#!/bin/bash
dnf install -y amazon-cloudwatch-agent
mkdir -p /opt/app
echo "Centralized logging test $(date)" >> /opt/app/app.log
cat >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<JSON
{"logs":{"logs_collected":{"files":{"collect_list":[{"file_path":"/opt/app/app.log","log_group_name":"/day7/application","log_stream_name":"{instance_id}"}]}}}}
JSON
systemctl enable --now amazon-cloudwatch-agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
EOF
) tags={Name="${var.project_name}-app"} }
