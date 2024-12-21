# Create a vpc
resource "aws_vpc" "vpc" {
    cidr_block                  = var.vpc_cidr
    instance_tenancy            = "default"
    enable_dns_support          = true
    
    tags                        = {
        Name                    = "${var.project_name}-vpc"
  }
}

# Create an internet gateway and attach it to the vpc
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id                      = aws_vpc.vpc.id

    tags                        = {
        Name                    = "${var.project_name}-internet_gateway"
    }  
}

# Use data source to get all availability zones in the region
data "aws_availability_zones" "available_zones" {}

# Create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
    vpc_id                      = aws_vpc.vpc.id
    cidr_block                  = var.public_subnet_az1_cidr
    availability_zone           = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch     = true

    tags                        = {
      Name                      = "${var.project_name}-public_subnet_az1"
    }
}

# Create public subnet az2
resource "aws_subnet" "public_subnet_az2" {
    vpc_id                      = aws_vpc.vpc.id
    cidr_block                  = var.public_subnet_az2_cidr
    availability_zone           = data.aws_availability_zones.available_zones.names[1]
    map_public_ip_on_launch     = true

    tags                        = {
      Name                      = "${var.project_name}-public_subnet_az2"
    }
}

# Create a public route table
resource "aws_route_table" "public_route_table" {
    vpc_id                      = aws_vpc.vpc.id

    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = aws_internet_gateway.internet_gateway.id
    }

    tags                        = {
      Name                      = "${var.project_name}-public_route_table"
    }
  
}

# Associate public subnet az1 to public route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
    subnet_id                   = aws_subnet.public_subnet_az1.id
    route_table_id              = aws_route_table.public_route_table.id
}

# Associate public subnet az2 to public route table
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
    subnet_id                   = aws_subnet.public_subnet_az2.id
    route_table_id              = aws_route_table.public_route_table.id
}

# Create private subnet az1
resource "aws_subnet" "private_subnet_az1" {
    vpc_id                      = aws_vpc.vpc.id
    cidr_block                  = var.private_subnet_az1_cidr
    availability_zone           = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch     = false

    tags                        = {
      Name                      = "${var.project_name}-private_subnet_az1"
    }
}

# Create private subnet az2
resource "aws_subnet" "private_subnet_az2" {
    vpc_id                      = aws_vpc.vpc.id
    cidr_block                  = var.private_subnet_az2_cidr
    availability_zone           = data.aws_availability_zones.available_zones.names[1]
    map_public_ip_on_launch     = false

    tags                        = {
      Name                      = "${var.project_name}-private_subnet_az2"
    }
}
