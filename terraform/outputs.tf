output "instance_id" {
  value = aws_instance.web.id
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}

output "public_ip" {
  value = aws_eip_association.eip_assoc.public_ip
}
