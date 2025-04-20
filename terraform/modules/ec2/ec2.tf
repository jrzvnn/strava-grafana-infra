resource "aws_instance" "ec2" {
  instance_type        = var.instance_type
  ami                  = var.ami
  subnet_id            = var.subnet_id
  key_name             = var.key_name
  security_groups      = var.security_group

  tags = {
    Name = var.host_name
  }
}

resource "aws_security_group" "security_group" {
  name    = var.sg_name
  vpc_id  = var.vpc_id
  tags = {
    Name =  var.sg_name
  }
}

resource "aws_security_group_rule" "source_sg" {
  count                     = length(var.source_sg) != 0 ? 1 : 0
  security_group_id         = var.sg_id
  source_security_group_id  = var.source_sg 
  protocol                  = var.protocol
  from_port                 = var.from_port
  to_port                   = var.to_port
  type                      = var.type
  description               = var.description
}

resource "aws_security_group_rule" "source_sg" {
  count                     = length(var.source_sg) != 0 ? 1 : 0
  security_group_id         = var.sg_id
  cidr_blocks               = var.source_ip
  protocol                  = var.protocol
  from_port                 = var.from_port
  to_port                   = var.to_port
  type                      = var.rule_type
  description               = var.description
}
