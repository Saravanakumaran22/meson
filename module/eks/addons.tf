resource "aws_eks_addon" "addons" {
  for_each = var.eks_addons

  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = each.key
  addon_version = each.value

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_node_group
  ]
}

resource "aws_eks_addon" "external_dns" {
  for_each = var.external_dns
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = each.key
  addon_version = each.value

  service_account_role_arn = aws_iam_role.external_dns_irsa_role.arn

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_node_group,
    aws_iam_role.external_dns_irsa_role,
    aws_iam_role_policy_attachment.external_dns_attach
  ]
}