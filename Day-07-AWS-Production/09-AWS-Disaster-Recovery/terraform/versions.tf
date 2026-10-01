terraform { required_version=">= 1.6.0" required_providers { aws={source="hashicorp/aws" version="~> 6.0"} random={source="hashicorp/random" version="~> 3.7"} } }
provider "aws" { region=var.primary_region default_tags {tags={ManagedBy="Terraform" Project=var.project_name}} }
provider "aws" { alias="dr" region=var.dr_region default_tags {tags={ManagedBy="Terraform" Project=var.project_name}} }
