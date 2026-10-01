output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "private_test_instance_id" {
  value = aws_instance.private_test.id
}

output "nat_gateway_id" {
  value = try(aws_nat_gateway.this[0].id, null)
}
