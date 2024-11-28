variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDR blocks for subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}


variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-02141377eee7defb9"  
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.medium"
}


