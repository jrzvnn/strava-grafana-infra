resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  security_groups             = [var.attach_sg]
  associate_public_ip_address = var.assign_pub_ip

  tags = {
    Name = var.name
  } 
}

resource "aws_eip" "eip" {
  count      = var.attach_eip ? 1 : 0
  domain     = "vpc"

  depends_on = [aws_instance.ec2_instance]
}

resource "aws_eip_association" "assign_pub_ip" {
  count         = var.attach_eip ? 1 : 0
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = aws_eip.eip[0].id
}
