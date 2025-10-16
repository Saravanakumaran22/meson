# meson

| Role                                         | Purpose                            | Policies Attached                                                                                              |
| -------------------------------------------- | ---------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| **EKS Cluster Role**                         | Manage cluster components          | `AmazonEKSClusterPolicy`                                                                                       |
| **EKS Node Role**                            | Allow EC2 nodes to join cluster    | `AmazonEKSWorkerNodePolicy`, `AmazonEC2ContainerRegistryReadOnly`, `AmazonEKS_CNI_Policy`, custom `EBS policy` |
| **EBS CSI Driver Role (IRSA)**               | Manage EBS volumes for storage     | `AmazonEBSCSIDriverPolicy`                                                                                     |
| **ExternalDNS Role (IRSA)**                  | Update Route53 DNS records         | Custom `external_dns_policy`                                                                                   |
| **AWS Load Balancer Controller Role (IRSA)** | Manage ALBs for Kubernetes Ingress | Custom `alb_controller_policy`                                                                                 |
