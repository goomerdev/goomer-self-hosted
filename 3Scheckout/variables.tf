variable "ami_id" {
  description = "AMI ID for Windows Server"
  type        = string
  default     = "ami-0c8eb251138004df2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.2xlarge"
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
  type        = string
  default     = "key-ec2-ninja"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-03b26120027d3fbe4"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-02830c7ceff8b894f"
}
