variable "ami_id" {
  description = "AMI ID for EC2 instances"
  
}

variable "instance_type" {
  description = "EC2 instance type"
  
}

variable "subnet_id" {
  description = "CIDR blocks for subnets"
 
}

variable "vpc_id" {
  description = "CIDR block for the VPC"
  
}

variable "sg_id" {
  description = "Security group id"
  
}