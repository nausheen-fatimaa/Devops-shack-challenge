data "aws_availability_zones" "available" { state = "available" }
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
locals {
  az1 = data.aws_availability_zones.available.names[0]
  az2 = data.aws_availability_zones.available.names[1]
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = "day7-p3-vpc" }
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "day7-p3-igw" }
}
resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.30.1.0/24"
  availability_zone = local.az1
  map_public_ip_on_launch = true
  tags = { Name = "day7-p3-public-a" }
}
resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.30.2.0/24"
  availability_zone = local.az2
  map_public_ip_on_launch = true
  tags = { Name = "day7-p3-public-b" }
}
resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.30.11.0/24"
  availability_zone = local.az1
  tags = { Name = "day7-p3-private-a" }
}
resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.30.12.0/24"
  availability_zone = local.az2
  tags = { Name = "day7-p3-private-b" }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route { cidr_block = "0.0.0.0/0"; gateway_id = aws_internet_gateway.this.id }
  tags = { Name = "day7-p3-public-rt" }
}
resource "aws_route_table_association" "public_a" { subnet_id = aws_subnet.public_a.id; route_table_id = aws_route_table.public.id }
resource "aws_route_table_association" "public_b" { subnet_id = aws_subnet.public_b.id; route_table_id = aws_route_table.public.id }

resource "aws_eip" "nat" { domain = "vpc" }
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public_a.id
  depends_on = [aws_internet_gateway.this]
  tags = { Name = "day7-p3-nat" }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route { cidr_block = "0.0.0.0/0"; nat_gateway_id = aws_nat_gateway.this.id }
  tags = { Name = "day7-p3-private-rt" }
}
resource "aws_route_table_association" "private_a" { subnet_id = aws_subnet.private_a.id; route_table_id = aws_route_table.private.id }
resource "aws_route_table_association" "private_b" { subnet_id = aws_subnet.private_b.id; route_table_id = aws_route_table.private.id }

resource "aws_security_group" "alb" {
  name = "day7-p3-alb-sg"
  vpc_id = aws_vpc.this.id
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}
resource "aws_security_group" "app" {
  name = "day7-p3-app-sg"
  vpc_id = aws_vpc.this.id
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; security_groups = [aws_security_group.alb.id] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_lb" "this" {
  name = "day7-p3-alb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}
resource "aws_lb_target_group" "app" {
  name = "day7-p3-targets"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.this.id
  health_check { path = "/" }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port = 80
  protocol = "HTTP"
  default_action { type = "forward"; target_group_arn = aws_lb_target_group.app.arn }
}

resource "aws_iam_role" "ec2" {
  name = "day7-p3-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{ Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole" }]
  })
}
resource "aws_iam_role_policy_attachment" "ssm" {
  role = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_instance_profile" "ec2" {
  name = "day7-p3-ec2-profile"
  role = aws_iam_role.ec2.name
}

resource "aws_launch_template" "app" {
  name_prefix = "day7-p3-app-"
  image_id = data.aws_ssm_parameter.al2023.value
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.app.id]
  iam_instance_profile { name = aws_iam_instance_profile.ec2.name }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y nginx
    systemctl enable --now nginx
    echo "<h1>Day 7 Project 3</h1><p>Auto Scaling Instance: $(hostname)</p>" > /usr/share/nginx/html/index.html
  EOF
  )
}

resource "aws_autoscaling_group" "app" {
  name = "day7-p3-asg"
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  max_size = var.max_size
  vpc_zone_identifier = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  health_check_type = "ELB"
  health_check_grace_period = 180

  launch_template {
    id = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app.arn]
  tag {
    key = "Name"
    value = "day7-p3-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu" {
  name = "day7-p3-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.app.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification { predefined_metric_type = "ASGAverageCPUUtilization" }
    target_value = 60
  }
}
