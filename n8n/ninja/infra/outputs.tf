output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.ninja_n8n.id
}

output "public_ip" {
  description = "Public IP address"
  value       = aws_instance.ninja_n8n.public_ip
}

output "private_ip" {
  description = "Private IP address"
  value       = aws_instance.ninja_n8n.private_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.ninja_n8n.id
}

output "iam_instance_profile" {
  description = "IAM Instance Profile name"
  value       = aws_iam_instance_profile.ssm_profile.name
}
