resource "aws_eks_cluster" "testekscluster" {
  name     = "test-eks-cluster"
  role_arn = aws_iam_role.Eks_Cluster_Role.arn #"arn:aws:iam::357028046444:role/AmazonEKSClusterPolicy"
  tags = {
    Name = "test-eks-cluster"
  }
  tags_all = {
    Name = "test-eks-cluster"
  }
  version = "1.28"
  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = "10.100.0.0/16"
  }

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    subnet_ids              = aws_subnet.private_subnet[*].id
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
  }
  depends_on = [aws_iam_role.Eks_Cluster_Role, aws_iam_role.Amazon_EKS_NodeRole, aws_vpc.my_vpc, aws_subnet.private_subnet, aws_security_group.eks_cluster_sg]
}
