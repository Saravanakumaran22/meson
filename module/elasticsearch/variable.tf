variable "namespace" {
  description = "Namespace to deploy Elasticsearch and Kibana"
  type        = string
  default     = "logging"
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "es_storage_size" {
  description = "Size of EBS volume for Elasticsearch nodes"
  type        = string

}

variable "es_replicas" {
  description = "Number of Elasticsearch replicas"
  type        = number

}

variable "kibana_replicas" {
  description = "Number of Kibana replicas"
  type        = number

}
