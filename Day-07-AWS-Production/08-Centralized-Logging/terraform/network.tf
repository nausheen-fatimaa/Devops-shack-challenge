data "aws_availability_zones" "available" { state = "available" }
locals { azs=slice(data.aws_availability_zones.available.names,0,2) }
resource "aws_vpc" "this" { cidr_block="10.80.0.0/16" enable_dns_support=true enable_dns_hostnames=true tags={Name="${var.project_name}-vpc"} }
resource "aws_internet_gateway" "this" { vpc_id=aws_vpc.this.id tags={Name="${var.project_name}-igw"} }
resource "aws_subnet" "public" { count=2 vpc_id=aws_vpc.this.id cidr_block=element(["10.80.1.0/24","10.80.2.0/24"],count.index) availability_zone=local.azs[count.index] map_public_ip_on_launch=true tags={Name="${var.project_name}-public-${count.index+1}",Tier="public"} }
resource "aws_subnet" "private" { count=2 vpc_id=aws_vpc.this.id cidr_block=element(["10.80.11.0/24","10.80.12.0/24"],count.index) availability_zone=local.azs[count.index] tags={Name="${var.project_name}-private-${count.index+1}",Tier="private"} }
resource "aws_route_table" "public" { vpc_id=aws_vpc.this.id route={cidr_block="0.0.0.0/0" gateway_id=aws_internet_gateway.this.id} tags={Name="${var.project_name}-public-rt"} }
resource "aws_route_table_association" "public" { count=2 subnet_id=aws_subnet.public[count.index].id route_table_id=aws_route_table.public.id }
resource "aws_eip" "nat" { count=2 domain="vpc" depends_on=[aws_internet_gateway.this] }
resource "aws_nat_gateway" "nat" { count=2 allocation_id=aws_eip.nat[count.index].id subnet_id=aws_subnet.public[count.index].id depends_on=[aws_internet_gateway.this] tags={Name="${var.project_name}-nat-${count.index+1}"} }
resource "aws_route_table" "private" { count=2 vpc_id=aws_vpc.this.id route={cidr_block="0.0.0.0/0" nat_gateway_id=aws_nat_gateway.nat[count.index].id} tags={Name="${var.project_name}-private-rt-${count.index+1}"} }
resource "aws_route_table_association" "private" { count=2 subnet_id=aws_subnet.private[count.index].id route_table_id=aws_route_table.private[count.index].id }
