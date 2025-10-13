variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Target VPC ID"
  type        = string
  default     = "vpc-0b2ed1981d9864fd2"
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 will be launched"
  type        = string
  default     = "subnet-03265512a856c2047"
}

variable "ami_id" {
  description = "AMI ID for the EC2"
  type        = string
  default     = "ami-03d9fcc39480315d4"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.micro"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "ninja-n8n"
}

variable "allowed_sg_id" {
  description = "Security Group ID allowed to reach this instance on TCP 5678"
  type        = string
  default     = "sg-0cca93afa1f441d41"
}

variable "associate_public_ip" {
  description = "Associate a public IP address to the instance"
  type        = bool
  default     = false
}
