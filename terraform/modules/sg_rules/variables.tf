variable "sg_id" {
  description = "Target security group ID"
  type        = string
}

variable "source_sg" {
  description = "Source security group ID"
  type        = string
  default     = ""
}

variable "source_ip" {
  description = "Source IP for security group rule"
  type        = list(string)
}

variable "protocol" {
  description = "Protocol (e.g., tcp, udp, -1)"
  type        = string
}

variable "from_port" {
  description = "Start port"
  type        = number
}

variable "to_port" {
  description = "End port"
  type        = number
}

variable "rule_type" {
  description = "Rule type (ingress/egress)"
  type        = string
}

variable "description" {
  description = "Rule description"
  type        = string
  default     = "Allow traffic from source SG"
}

variable "enable_source_sg" {
  type    = bool
  default = false
}


