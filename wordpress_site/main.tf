# Configure required provider
terraform{
    required_providers {
      aws                   = {
        source              = "hashicorp/aws"
        version             = "~> 5.0"
      }
    }
    required_version        = ">= 1.9.8"
}

# Create the vpc & contents in the vpc module
module "vpc" {
  source                    = "./modules/vpc"
  region                    = var.region
  project_name              = var.project_name
  vpc_cidr                  = var.vpc_cidr
  public_subnet_az1_cidr    = var.public_subnet_az1_cidr
  public_subnet_az2_cidr    = var.public_subnet_az2_cidr
  private_subnet_az1_cidr   = var.private_subnet_az1_cidr
  private_subnet_az2_cidr   = var.private_subnet_az2_cidr
}