resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.sg_id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy
  ]
}

data "aws_ami" "eks" {
  most_recent = true
  owners      = ["602401143452"] 

  filter {
    name   = "name"
    values = ["amazon-eks-node-1.32-v*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_launch_template" "eks_nodes" {
  name_prefix   = "${var.env}-eks-spot"
  image_id      = data.aws_ami.eks.id
  instance_type = var.node_instance_types[0]
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.sg_id]
  }
  user_data = base64encode(<<EOF
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${var.cluster_name} --kubelet-extra-args '--node-labels=env=${var.env},spot=true'
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.env}-eks-spot-node"
      Environment = var.env
    }
  }

  depends_on = [ 
    aws_eks_cluster.eks_cluster
   ]
}


resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.env}-spot-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids
  capacity_type   = var.capacity_type

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = var.desired_nodes
    min_size     = var.min_nodes
    max_size     = var.max_nodes
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Environment = var.env
    Name        = "${var.env}-eks-spot-nodes"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy,
    aws_eks_cluster.eks_cluster,
    aws_launch_template.eks_nodes
  ]
}



