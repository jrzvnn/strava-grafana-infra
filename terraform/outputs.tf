output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "grafana_sg_id" {
  value = module.sg_grafana.sg_id
}

output "nginx_sg_id" {
  value = module.sg_nginx.sg_id
}

output "nginx_ec2_id" {
  value = module.ec2_nginx
}

output "grafana_ec2_id" {
  value = module.ec2_grafana
}

