# # output "cluster_name" {
# #   value = aws_eks_cluster.dev-eks.name
# # }

# # EKS Cluster Name
# output "cluster_name" {
#   description = "The name of the EKS cluster"
#   value       = aws_eks_cluster.dev-eks.name
# }

# # EKS Cluster ARN
# output "cluster_arn" {
#   description = "The ARN of the EKS cluster"
#   value       = aws_eks_cluster.dev-eks.arn
# }

# # EKS Cluster endpoint
# output "cluster_endpoint" {
#   description = "The endpoint of the EKS cluster"
#   value       = aws_eks_cluster.dev-eks.endpoint
# }

# # EKS Cluster certificate authority data
# output "cluster_certificate_authority_data" {
#   description = "Certificate authority data for the EKS cluster"
#   value       = aws_eks_cluster.dev-eks.certificate_authority[0].data
# }

# # EKS Node Group Name
# output "node_group_name" {
#   description = "The name of the EKS node group"
#   value       = aws_eks_node_group.dev-eks.node_group_name
# }

# # EKS Node Group ARN
# output "node_group_arn" {
#   description = "The ARN of the EKS node group"
#   value       = aws_eks_node_group.dev-eks.arn
# }

# # EKS Node Role ARN
# output "node_role_arn" {
#   description = "IAM Role ARN associated with the EKS nodes"
#   value       = aws_iam_role.eks_node_role.arn
# }

# # Security Group ID for EKS Nodes
# output "node_sg_id" {
#   description = "Security group ID attached to the EKS node group"
#   value       = aws_eks_node_group.dev-eks.resources[0].auto_scaling_groups[0].security_groups[0]
# }
