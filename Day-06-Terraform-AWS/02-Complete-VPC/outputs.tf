output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_a_id" {
  description = "Public subnet A ID"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "Public subnet B ID"
  value       = aws_subnet.public_b.id
}

output "web_a_public_ip" {
  description = "Public IP of Web Server A"
  value       = aws_instance.web_a.public_ip
}

output "web_b_public_ip" {
  description = "Public IP of Web Server B"
  value       = aws_instance.web_b.public_ip
}

output "web_a_url" {
  description = "URL of Web Server A"
  value       = "http://${aws_instance.web_a.public_ip}"
}

output "web_b_url" {
  description = "URL of Web Server B"
  value       = "http://${aws_instance.web_b.public_ip}"
}