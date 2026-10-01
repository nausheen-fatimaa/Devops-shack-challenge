resource "aws_subnet" "isolated" { count=2 vpc_id=aws_vpc.this.id cidr_block=element(["10.100.21.0/24","10.100.22.0/24"],count.index) availability_zone=local.azs[count.index] tags={Name="${var.project_name}-isolated-${count.index+1}",Tier="isolated"} }
resource "aws_route_table" "isolated" { count=2 vpc_id=aws_vpc.this.id tags={Name="${var.project_name}-isolated-rt-${count.index+1}"} }
resource "aws_route_table_association" "isolated" { count=2 subnet_id=aws_subnet.isolated[count.index].id route_table_id=aws_route_table.isolated[count.index].id }
