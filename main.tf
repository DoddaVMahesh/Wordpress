# VPC Module
module "vpc" {
  source           = "./modules/vpc"
  vpc_id         = var.vpc_cidr
  subnet_id     = var.subnet_cidrs
  
}

# EC2 Module
module "ec2" {
  source       = "./modules/ec2"
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_ids[0]
  sg_id        = aws_security_group.sg.id
  ami_id       = var.ami_id
  instance_type = var.instance_type
}

resource "aws_internet_gateway" "main" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "MainInternetGateway"
  }
}

resource "aws_route_table" "main" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "MainRouteTable"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}



resource "aws_route_table_association" "main" {
  subnet_id      = module.vpc.public_subnet_ids[0]
  route_table_id = aws_route_table.main.id
}