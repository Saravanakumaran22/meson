# Outputs for EKS module
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority" {
  description = "The cluster CA for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_node_role_arn" {
  description = "The IAM role ARN for the EKS node group"
  value       = aws_iam_role.eks_node_role.arn
}
