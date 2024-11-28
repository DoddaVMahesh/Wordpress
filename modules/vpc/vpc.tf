resource "aws_vpc" "main" {
  cidr_block = var.vpc_id
  
}

resource "aws_subnet" "subnets" {
  count                   = length(var.subnet_id)
  cidr_block              = var.subnet_id[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
}



output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.subnets[*].id
}

