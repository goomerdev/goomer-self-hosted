output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.tools_3scheckout.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.tools_3scheckout.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.tools_3scheckout.private_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.tools_3scheckout_sg.id
}
