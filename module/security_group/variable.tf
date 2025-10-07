variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

variable "ingress_rules" {
  description = "Ingress rules for the EKS security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}