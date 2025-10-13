terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# Security Group for RDP access
resource "aws_security_group" "tools_3scheckout_sg" {
  name        = "tools-3scheckout-sg"
  description = "Security group for tools-3Scheckout EC2 instance - RDP access"
  vpc_id      = var.vpc_id

  ingress {
    description = "RDP from anywhere"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tools-3scheckout-sg"
  }
}

# EC2 Instance
resource "aws_instance" "tools_3scheckout" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.tools_3scheckout_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "tools-3Scheckout"
  }
}
