output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "instance_id" {
  value = module.web.instance_id
}

output "public_ip" {
  value = module.web.public_ip
}

output "website_url" {
  value = module.web.website_url
}
