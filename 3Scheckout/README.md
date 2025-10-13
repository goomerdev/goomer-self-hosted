# EC2 Windows Instance - tools-3Scheckout

This Terraform configuration creates a Windows EC2 instance with RDP access.

## Specifications

- **Name**: tools-3Scheckout
- **AMI**: ami-0c8eb251138004df2
- **Instance Type**: t3.2xlarge
- **Key Pair**: key-ec2-ninja
- **VPC**: vpc-03b26120027d3fbe4
- **Subnet**: subnet-02830c7ceff8b894f
- **Auto-assign Public IP**: Yes
- **Security Group**: Custom security group with RDP (port 3389) access from anywhere

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```

## Outputs

After applying, you'll get the following outputs:
- **instance_id**: The EC2 instance ID
- **instance_public_ip**: The public IP address for RDP connection
- **instance_private_ip**: The private IP address
- **security_group_id**: The security group ID

## Security Note

The security group allows RDP access (port 3389) from any IP address (0.0.0.0/0). For production environments, consider restricting access to specific IP ranges.
