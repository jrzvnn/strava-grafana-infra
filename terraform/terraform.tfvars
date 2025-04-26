project         = "strava-grafana"
vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.0.0/24"]
private_subnets = ["10.0.1.0/24"]
azs             = ["ap-southeast-1a", "ap-southeast-1b"]
ami_id          = "ami-05ab12222a9f39021"
instance_type   = "t2.micro"
key_name        = "ec2-ssh-key"


