module "vpc" {
  source          = "./modules/vpc"
  project         = var.project
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "sg_nginx" {
  source  = "./modules/sg"
  sg_name = "nginx-sg" 
  vpc_id  = module.vpc.vpc_id
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

