################################################################################
# Resource: aws_vpc
################################################################################

module "vpc" {
  source          = "./modules/vpc"
  project         = var.project
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  azs             = var.azs
}

################################################################################
# Resource: aws_security_group
################################################################################

module "sg_nginx" {
  source  = "./modules/sg"
  sg_name = "nginx-sg" 
  vpc_id  = module.vpc.vpc_id
}

module "nginx_ingress_port_22" {
  source = "./modules/sg_rules"
  rule_type                 = "ingress"
  sg_id                     = module.sg_nginx.sg_id
  source_sg                 = "" 
  source_ip                 = ["0.0.0.0/0"]
  protocol                  = "TCP"
  from_port                 = "22"
  to_port                   = "22"
  description               = "Allow all port 22 inbound traffic to Nginx"
}

module "nginx_ingress_port_80" {
  source = "./modules/sg_rules"
  rule_type                 = "ingress"
  sg_id                     = module.sg_nginx.sg_id
  source_sg                 = "" 
  source_ip                 = ["0.0.0.0/0"]
  protocol                  = "TCP"
  from_port                 = "80"
  to_port                   = "80"
  description               = "Allow all port 80 inbound traffic to Nginx"
}

module "nginx_egress_port_80" {
  source = "./modules/sg_rules"
  rule_type                 = "egress"
  sg_id                     = module.sg_nginx.sg_id
  source_sg                 = "" 
  source_ip                 = ["0.0.0.0/0"]
  protocol                  = "-1"
  from_port                 = "0"
  to_port                   = "0"
  description               = "Allow all outbound traffic from Nginx"
}

module "sg_grafana" {
  source  = "./modules/sg"
  sg_name = "grafana-sg" 
  vpc_id  = module.vpc.vpc_id
}

module "grafana_ingress_port_3000" {
  source = "./modules/sg_rules"
  rule_type                 = "ingress"
  sg_id                     = module.sg_grafana.sg_id
  enable_source_sg          = true 
  source_sg                 = module.sg_nginx.sg_id 
  source_ip                 = []
  protocol                  = "TCP"
  from_port                 = "3000"
  to_port                   = "3000"
  description               = "Allow inbound traffic to Grafana from Nginx only"
}

module "grafana_ingress_port_22" {
  source = "./modules/sg_rules"
  rule_type                 = "ingress"
  sg_id                     = module.sg_grafana.sg_id
  source_sg                 = "" 
  source_ip                 = ["0.0.0.0/0"]
  protocol                  = "TCP"
  from_port                 = "22"
  to_port                   = "22"
  description               = "Allow all port 22 inbound traffic to Nginx"
}


module "grafana_egress_open" {
  source = "./modules/sg_rules"
  rule_type                 = "egress"
  sg_id                     = module.sg_grafana.sg_id
  source_sg                 = "" 
  source_ip                 = ["0.0.0.0/0"]   
  protocol                  = "-1"
  from_port                 = 0
  to_port                   = 0
  description               = "Allow any outbound traffic from grafana"
}

################################################################################
# Resource: aws_instance
################################################################################

module "ec2_nginx" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  key_name      = var.key_name
  attach_sg     = module.sg_nginx.sg_id
  assign_pub_ip = false
  name          = "nginx"
  attach_eip    = true
}

module "ec2_grafana" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  key_name      = var.key_name
  attach_sg     = module.sg_grafana.sg_id
  assign_pub_ip = true
  name          = "grafana"
  attach_eip    = false
}
