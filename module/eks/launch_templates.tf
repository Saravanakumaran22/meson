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
