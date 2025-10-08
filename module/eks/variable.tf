variable "cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}

variable "cluster_region" {
  type        = string
  description = "AWS Region"
}

variable "node_instance_types" {
  type        = list(string)
  description = "Instance types for spot nodes"
}

variable "desired_nodes" {
  type        = number
  description = "Desired node count"
}

variable "min_nodes" {
  type        = number
  description = "Minimum nodes"
}

variable "max_nodes" {
  type        = number
  description = "Maximum nodes"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for EKS nodes"
}

variable "key_name" {
  type        = string
  description = "Key for Spot instance"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "sg_id" {
  type        = string
  description = "Security group ID for EKS nodes"
}

variable "eks_addons" {
  type = map(string)
  description = "Map of EKS addons with their versions"
}

variable "external_dns" {
  type = object({
    addon_name    = string
    addon_version = string
  })
  description = "External DNS addon configuration with name and version"
}

variable "capacity_type" {
  type        = string
  description = "Capacity type for intsance"
}










