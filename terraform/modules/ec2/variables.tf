variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "key_name" {}
variable "attach_sg" {}
variable "name" {}
variable "assign_pub_ip" {
  
}
variable "attach_eip" {
  type    = bool
  default = false
}
