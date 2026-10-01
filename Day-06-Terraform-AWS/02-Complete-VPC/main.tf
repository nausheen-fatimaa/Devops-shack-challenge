data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

# -------------------------
# VPC
# -------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project2-vpc"
  }
}

# -------------------------
# Public Subnet A
# -------------------------

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "project2-public-a"
  }
}

# -------------------------
# Public Subnet B
# -------------------------

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "project2-public-b"
  }
}

# -------------------------
# Internet Gateway
# -------------------------

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project2-igw"
  }
}

# -------------------------
# Public Route Table
# -------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "project2-public-rt"
  }
}

# -------------------------
# Route Table Association A
# -------------------------

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Route Table Association B
# -------------------------

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Security Group
# -------------------------

resource "aws_security_group" "web" {
  name        = "project2-web-sg"
  description = "Security group for Project 2 web servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project2-web-sg"
  }
}

# -------------------------
# EC2 Instance A
# -------------------------

resource "aws_instance" "web_a" {
  ami                         = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y
              apt-get install -y nginx

              systemctl enable nginx
              systemctl start nginx

              echo "<h1>Project 2 - Public Subnet A</h1>" > /var/www/html/index.html
              echo "<p>Terraform VPC Project</p>" >> /var/www/html/index.html
              EOF

  tags = {
    Name = "project2-web-a"
  }
}

# -------------------------
# EC2 Instance B
# -------------------------

resource "aws_instance" "web_b" {
  ami                         = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_b.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y
              apt-get install -y nginx

              systemctl enable nginx
              systemctl start nginx

              echo "<h1>Project 2 - Public Subnet B</h1>" > /var/www/html/index.html
              echo "<p>Terraform VPC Project</p>" >> /var/www/html/index.html
              EOF

  tags = {
    Name = "project2-web-b"
  }
}