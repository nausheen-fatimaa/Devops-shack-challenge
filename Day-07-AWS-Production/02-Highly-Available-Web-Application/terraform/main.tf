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
  tags = { Name = "day7-p2-vpc" }
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "day7-p2-igw" }
}

resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.20.1.0/24"
  availability_zone = local.az1
  map_public_ip_on_launch = true
  tags = { Name = "day7-p2-public-a" }
}
resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.20.2.0/24"
  availability_zone = local.az2
  map_public_ip_on_launch = true
  tags = { Name = "day7-p2-public-b" }
}
resource "aws_subnet" "app_a" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.20.11.0/24"
  availability_zone = local.az1
  tags = { Name = "day7-p2-app-a" }
}
resource "aws_subnet" "app_b" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.20.12.0/24"
  availability_zone = local.az2
  tags = { Name = "day7-p2-app-b" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route { cidr_block = "0.0.0.0/0"; gateway_id = aws_internet_gateway.this.id }
  tags = { Name = "day7-p2-public-rt" }
}
resource "aws_route_table_association" "public_a" {
  subnet_id = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" { count = var.enable_nat_gateway ? 1 : 0; domain = "vpc" }
resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id = aws_subnet.public_a.id
  depends_on = [aws_internet_gateway.this]
  tags = { Name = "day7-p2-nat" }
}
resource "aws_route_table" "app" {
  vpc_id = aws_vpc.this.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.this[0].id
    }
  }

  tags = { Name = "day7-p2-app-rt" }
}
resource "aws_route_table_association" "app_a" {
  subnet_id = aws_subnet.app_a.id
  route_table_id = aws_route_table.app.id
}
resource "aws_route_table_association" "app_b" {
  subnet_id = aws_subnet.app_b.id
  route_table_id = aws_route_table.app.id
}

resource "aws_security_group" "alb" {
  name = "day7-p2-alb-sg"
  vpc_id = aws_vpc.this.id
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}
resource "aws_security_group" "app" {
  name = "day7-p2-app-sg"
  vpc_id = aws_vpc.this.id
  ingress {
    from_port = 80; to_port = 80; protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_lb" "this" {
  name = "day7-p2-alb"
  load_balancer_type = "application"
  internal = false
  security_groups = [aws_security_group.alb.id]
  subnets = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}
resource "aws_lb_target_group" "app" {
  name = "day7-p2-targets"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.this.id
  health_check { path = "/"; matcher = "200-399" }
}

resource "aws_iam_role" "ssm" {
  name = "day7-p2-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{ Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole" }]
  })
}
resource "aws_iam_role_policy_attachment" "ssm" {
  role = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_instance_profile" "ssm" {
  name = "day7-p2-ssm-profile"
  role = aws_iam_role.ssm.name
}

resource "aws_instance" "app" {
  count = 2
  ami = data.aws_ssm_parameter.al2023.value
  instance_type = var.instance_type
  subnet_id = count.index == 0 ? aws_subnet.app_a.id : aws_subnet.app_b.id
  vpc_security_group_ids = [aws_security_group.app.id]
  associate_public_ip_address = false
  iam_instance_profile = aws_iam_instance_profile.ssm.name

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nginx
    systemctl enable --now nginx
    echo "<h1>Day 7 Project 2 - $(hostname)</h1><p>Highly Available Web Application</p>" > /usr/share/nginx/html/index.html
  EOF

  tags = { Name = "day7-p2-app-${count.index + 1}" }
}

resource "aws_lb_target_group_attachment" "app" {
  count = 2
  target_group_arn = aws_lb_target_group.app.arn
  target_id = aws_instance.app[count.index].id
  port = 80
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
