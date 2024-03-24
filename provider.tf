terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"

}

resource "null_resource" "argo_install" {
  provisioner "local-exec" {
    command = <<EOT
      sudo chmod 777 kubesetup.sh
      sudo bash ${path.module}/kubesetup.sh
    EOT

    #working_dir = "/tmp"  # You can change the working directory as needed
  }
depends_on=[aws_eks_cluster.testekscluster,aws_eks_node_group.testeksclusternode]
}
