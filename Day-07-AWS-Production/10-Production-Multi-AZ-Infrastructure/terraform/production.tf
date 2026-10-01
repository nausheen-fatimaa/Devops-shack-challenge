data "aws_ssm_parameter" "al2023" { name="/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64" }
resource "random_password" "db" { length=20 special=true override_special="!#$%&()*+,-.:;<=>?@[]^_{|}~" }
resource "aws_security_group" "alb" { name_prefix="${var.project_name}-alb-" vpc_id=aws_vpc.this.id ingress {from_port=80 to_port=80 protocol="tcp" cidr_blocks=["0.0.0.0/0"]} egress {from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"]} }
resource "aws_security_group" "app" { name_prefix="${var.project_name}-app-" vpc_id=aws_vpc.this.id ingress {from_port=80 to_port=80 protocol="tcp" security_groups=[aws_security_group.alb.id]} egress {from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"]} }
resource "aws_security_group" "db" { name_prefix="${var.project_name}-db-" vpc_id=aws_vpc.this.id ingress {from_port=3306 to_port=3306 protocol="tcp" security_groups=[aws_security_group.app.id]} egress {from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"]} }
resource "aws_lb" "this" { name="${var.project_name}-alb" load_balancer_type="application" subnets=aws_subnet.public[*].id security_groups=[aws_security_group.alb.id] }
resource "aws_lb_target_group" "app" { name="${var.project_name}-tg" port=80 protocol="HTTP" vpc_id=aws_vpc.this.id health_check {path="/"} }
resource "aws_lb_listener" "http" { load_balancer_arn=aws_lb.this.arn port=80 protocol="HTTP" default_action {type="forward" target_group_arn=aws_lb_target_group.app.arn} }
resource "aws_iam_role" "ssm" { name="${var.project_name}-ssm" assume_role_policy=jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Principal={Service="ec2.amazonaws.com"},Action="sts:AssumeRole"}]}) }
resource "aws_iam_role_policy_attachment" "ssm" { role=aws_iam_role.ssm.name policy_arn="arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" }
resource "aws_iam_instance_profile" "ssm" { name="${var.project_name}-profile" role=aws_iam_role.ssm.name }
resource "aws_launch_template" "app" { name_prefix="${var.project_name}-" image_id=data.aws_ssm_parameter.al2023.value instance_type=var.instance_type iam_instance_profile {name=aws_iam_instance_profile.ssm.name} vpc_security_group_ids=[aws_security_group.app.id] user_data=base64encode(<<-EOF
#!/bin/bash
dnf install -y nginx
echo '<h1>Production Multi-AZ Infrastructure</h1><p>$(hostname)</p>' >/usr/share/nginx/html/index.html
systemctl enable --now nginx
EOF
) }
resource "aws_autoscaling_group" "app" { name="${var.project_name}-asg" min_size=2 max_size=6 desired_capacity=2 vpc_zone_identifier=aws_subnet.private[*].id launch_template {id=aws_launch_template.app.id version="$Latest"} target_group_arns=[aws_lb_target_group.app.arn] health_check_type="ELB" health_check_grace_period=180 }
resource "aws_autoscaling_policy" "cpu" { name="${var.project_name}-cpu-target" autoscaling_group_name=aws_autoscaling_group.app.name policy_type="TargetTrackingScaling" target_tracking_configuration {predefined_metric_specification {predefined_metric_type="ASGAverageCPUUtilization"} target_value=50} }
resource "aws_cloudwatch_metric_alarm" "cpu" { alarm_name="${var.project_name}-cpu-high" comparison_operator="GreaterThanThreshold" evaluation_periods=2 metric_name="CPUUtilization" namespace="AWS/EC2" period=300 statistic="Average" threshold=80 dimensions={AutoScalingGroupName=aws_autoscaling_group.app.name} }
resource "aws_db_subnet_group" "db" { name="${var.project_name}-db-subnets" subnet_ids=aws_subnet.isolated[*].id }
resource "aws_db_instance" "db" { identifier="${var.project_name}-mysql" engine="mysql" engine_version="8.0" instance_class=var.db_instance_class allocated_storage=20 storage_type="gp3" db_name=var.db_name username="appadmin" password=random_password.db.result db_subnet_group_name=aws_db_subnet_group.db.name vpc_security_group_ids=[aws_security_group.db.id] publicly_accessible=false multi_az=true backup_retention_period=7 deletion_protection=false skip_final_snapshot=true }
