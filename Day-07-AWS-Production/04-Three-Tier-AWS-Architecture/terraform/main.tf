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
  tags = { Name = "day7-p4-vpc" }
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "day7-p4-igw" }
}

resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.this.id; cidr_block = "10.40.1.0/24"; availability_zone = local.az1; map_public_ip_on_launch = true
  tags = { Name = "day7-p4-public-a" }
}
resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.this.id; cidr_block = "10.40.2.0/24"; availability_zone = local.az2; map_public_ip_on_launch = true
  tags = { Name = "day7-p4-public-b" }
}
resource "aws_subnet" "app_a" {
  vpc_id = aws_vpc.this.id; cidr_block = "10.40.11.0/24"; availability_zone = local.az1
  tags = { Name = "day7-p4-app-a" }
}
resource "aws_subnet" "app_b" {
  vpc_id = aws_vpc.this.id; cidr_block = "10.40.12.0/24"; availability_zone = local.az2
  tags = { Name = "day7-p4-app-b" }
}
resource "aws_subnet" "db_a" {
  vpc_id = aws_vpc.this.id; cidr_block = "10.40.21.0/24"; availability_zone = local.az1
  tags = { Name = "day7-p4-db-a" }
}
resource "aws_subnet" "db_b" {
  vpc_id = aws_vpc.this.id; cidr_block = "10.40.22.0/24"; availability_zone = local.az2
  tags = { Name = "day7-p4-db-b" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route { cidr_block = "0.0.0.0/0"; gateway_id = aws_internet_gateway.this.id }
  tags = { Name = "day7-p4-public-rt" }
}
resource "aws_route_table_association" "public_a" { subnet_id = aws_subnet.public_a.id; route_table_id = aws_route_table.public.id }
resource "aws_route_table_association" "public_b" { subnet_id = aws_subnet.public_b.id; route_table_id = aws_route_table.public.id }

resource "aws_eip" "nat" { domain = "vpc" }
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id; subnet_id = aws_subnet.public_a.id
  depends_on = [aws_internet_gateway.this]
  tags = { Name = "day7-p4-nat" }
}
resource "aws_route_table" "app" {
  vpc_id = aws_vpc.this.id
  route { cidr_block = "0.0.0.0/0"; nat_gateway_id = aws_nat_gateway.this.id }
  tags = { Name = "day7-p4-app-rt" }
}
resource "aws_route_table_association" "app_a" { subnet_id = aws_subnet.app_a.id; route_table_id = aws_route_table.app.id }
resource "aws_route_table_association" "app_b" { subnet_id = aws_subnet.app_b.id; route_table_id = aws_route_table.app.id }


resource "random_password" "db" {
  length           = 24
  special          = false
  upper            = true
  lower            = true
  numeric          = true
  override_special = ""
}

resource "aws_db_subnet_group" "this" {
  name = "day7-p4-db-subnets"
  subnet_ids = [aws_subnet.db_a.id, aws_subnet.db_b.id]
}

resource "aws_security_group" "alb" {
  name = "day7-p4-alb-sg"; vpc_id = aws_vpc.this.id
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}
resource "aws_security_group" "app" {
  name = "day7-p4-app-sg"; vpc_id = aws_vpc.this.id
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; security_groups = [aws_security_group.alb.id] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}
resource "aws_security_group" "db" {
  name = "day7-p4-db-sg"; vpc_id = aws_vpc.this.id
  ingress { from_port = 3306; to_port = 3306; protocol = "tcp"; security_groups = [aws_security_group.app.id] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_lb" "this" {
  name = "day7-p4-alb"; load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}
resource "aws_lb_target_group" "app" {
  name = "day7-p4-targets"; port = 80; protocol = "HTTP"; vpc_id = aws_vpc.this.id
  health_check { path = "/" }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn; port = 80; protocol = "HTTP"
  default_action { type = "forward"; target_group_arn = aws_lb_target_group.app.arn }
}

resource "aws_iam_role" "ec2" {
  name = "day7-p4-ec2-role"
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
  name = "day7-p4-ec2-profile"; role = aws_iam_role.ec2.name
}

resource "aws_instance" "app" {
  count = 2
  ami = data.aws_ssm_parameter.al2023.value
  instance_type = var.instance_type
  subnet_id = count.index == 0 ? aws_subnet.app_a.id : aws_subnet.app_b.id
  vpc_security_group_ids = [aws_security_group.app.id]
  associate_public_ip_address = false
  iam_instance_profile = aws_iam_instance_profile.ec2.name
  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nginx
    systemctl enable --now nginx
    echo "<h1>Day 7 Project 4 - Three Tier</h1><p>App Server: $(hostname)</p>" > /usr/share/nginx/html/index.html
  EOF
  tags = { Name = "day7-p4-app-${count.index + 1}" }
}
resource "aws_lb_target_group_attachment" "app" {
  count = 2; target_group_arn = aws_lb_target_group.app.arn; target_id = aws_instance.app[count.index].id; port = 80
}

resource "aws_db_instance" "this" {
  identifier = "day7-p4-mysql"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = var.db_instance_class
  allocated_storage = 20
  max_allocated_storage = 50
  db_name = var.db_name
  username = var.db_username
  password = random_password.db.result
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible = false
  multi_az = true
  storage_encrypted = true
  backup_retention_period = 7
  skip_final_snapshot = true
  deletion_protection = false
}
