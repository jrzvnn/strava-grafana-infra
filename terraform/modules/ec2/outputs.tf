output "id" {
  value = aws_instance.ec2_instance.id
}

output "name" {
  value = aws_instance.ec2_instance.tags["Name"]
}

output "private_ip" {
  value = aws_instance.ec2_instance.private_ip
}

output "private_dns" {
  value = aws_instance.ec2_instance.private_dns
}

output "eip_public_ip" {
  value = length(aws_eip.eip) > 0 ? aws_eip.eip[0].public_ip : null
}
