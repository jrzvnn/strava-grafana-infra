variable "key_name" {
  description = "SSH key pair for EC2 instance"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet for EC2 instance"
  type        = string
}

variable "host_name" {
  description = "Name for EC2 instance"
  type        = string
}

variable "security_group" {
  description = "SG for EC2 instances"
}

