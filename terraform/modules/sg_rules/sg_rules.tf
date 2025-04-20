resource "aws_security_group_rule" "source_sg" {
  count                     = var.enable_source_sg != 0 ? 1 : 0
  type                      = var.rule_type
  security_group_id         = var.sg_id
  source_security_group_id  = var.source_sg 
  protocol                  = var.protocol
  from_port                 = var.from_port
  to_port                   = var.to_port
  description               = var.description
}

resource "aws_security_group_rule" "source_ip" {
  count                     = length(var.source_ip) != 0 ? 1 : 0
  security_group_id         = var.sg_id
  cidr_blocks               = var.source_ip
  protocol                  = var.protocol
  from_port                 = var.from_port
  to_port                   = var.to_port
  type                      = var.rule_type
  description               = var.description
}

