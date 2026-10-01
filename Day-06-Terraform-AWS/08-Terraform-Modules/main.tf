module "network" {
  source = "./modules/network"

  vpc_cidr     = var.vpc_cidr
  project_name = "project8"
}

module "web" {
  source = "./modules/web"

  vpc_id       = module.network.vpc_id
  subnet_id    = module.network.public_subnet_id
  project_name = "project8"
}
