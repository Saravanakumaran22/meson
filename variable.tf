variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ca-central-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "dev-cluster"
}

variable "node_instance_types" {
  description = "Instance types for spot nodes"
  type        = list(string)
  default     = ["t3.medium", "t3.medium"]
}

variable "desired_nodes" {
  description = "Desired node count"
  type        = number
  default     = 3
}

variable "min_nodes" {
  description = "Minimum nodes"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum nodes"
  type        = number
  default     = 3
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "subnet_ids" {
  description = "Subnets for EKS nodes"
  type        = list(string)
  default     = ["subnet-03cb2046605775c10", "subnet-08cd0d747ed3b0d01"]
}

variable "key_name" {
  description = "Key for Spot instance"
  type        = string
  default     = "demo-saravana"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-05cc79f38d53a332e"
}

variable "eks_addons" {
  description = "Map of EKS addons with their versions"
  type        = map(string)
  default = {
    coredns                   = "v1.12.4-eksbuild.1"
    kube-proxy                = "v1.33.3-eksbuild.4"
    vpc-cni                   = "v1.19.5-eksbuild.1"
    metrics-server            = "v0.8.0-eksbuild.2"
    aws-ebs-csi-driver        = "v1.48.0-eksbuild.1"
    eks-node-monitoring-agent = "v1.4.0-eksbuild.2"
    eks-pod-identity-agent    = "v1.3.8-eksbuild.2"
    cert-manager              = "v1.18.2-eksbuild.2"
  }
}

variable "external_dns" {
  type = object({
    addon_name    = string
    addon_version = string
  })
  description = "External DNS addon configuration with name and version"
  default = {
    addon_name    = "external-dns"
    addon_version = "v0.19.0-eksbuild.2"
  }
}

variable "capacity_type" {
  type        = string
  description = "Capacity type for intsance"
  default     = "SPOT"
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

  default = [
    {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

