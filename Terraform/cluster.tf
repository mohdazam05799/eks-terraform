resource "aws_eks_cluster" "eks_cluster" {
  role_arn = aws_iam_role.eks_master_role.arn
  name     = "${var.environment}_eks_cluster"
  version  = var.cluster_version
  vpc_config {
    subnet_ids              = aws_subnet.Public[*].id
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_ciders

  }
  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
  ]

}