resource "aws_security_group" "ninja_n8n" {
  name        = "${var.instance_name}-sg"
  description = "Security group for ${var.instance_name}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

resource "aws_security_group_rule" "allow_5678_from_sg" {
  type                     = "ingress"
  description              = "Allow TCP 5678 from SG ${var.allowed_sg_id}"
  from_port                = 5678
  to_port                  = 5678
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ninja_n8n.id
  source_security_group_id = var.allowed_sg_id
}

resource "aws_iam_role" "ssm_role" {
  name_prefix = "${var.instance_name}-ssm-"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "ec2.amazonaws.com" },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.instance_name}-ssm-role"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name_prefix = "${var.instance_name}-ssm-"
  role        = aws_iam_role.ssm_role.name
}

resource "aws_instance" "ninja_n8n" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.ninja_n8n.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  associate_public_ip_address = var.associate_public_ip

  user_data = <<-EOF
              #!/bin/bash
              set -euxo pipefail

              # Update and install SSM Agent depending on distro
              if command -v apt-get >/dev/null 2>&1; then
                export DEBIAN_FRONTEND=noninteractive
                apt-get update -y || true
                apt-get install -y amazon-ssm-agent || true
                if ! systemctl list-unit-files | grep -q amazon-ssm-agent; then
                  # Fallback to snap on Ubuntu
                  if command -v snap >/dev/null 2>&1; then
                    snap install amazon-ssm-agent --classic || true
                    systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service || true
                    systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service || true
                  fi
                fi
              elif command -v yum >/dev/null 2>&1; then
                yum install -y amazon-ssm-agent || true
              elif command -v dnf >/dev/null 2>&1; then
                dnf install -y amazon-ssm-agent || true
              fi

              systemctl enable amazon-ssm-agent || true
              systemctl start amazon-ssm-agent || true

              EOF

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = var.instance_name
  }

  depends_on = [
    aws_iam_instance_profile.ssm_profile,
    aws_iam_role_policy_attachment.ssm_core
  ]
}
