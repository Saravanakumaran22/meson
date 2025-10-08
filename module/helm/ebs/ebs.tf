resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.ebs_volume_zone   
  size              = var.ebs_volume_size
  type              = var.ebs_volume_type
  tags = {
    Name = "nginx-ebs-volume"
  }
}

