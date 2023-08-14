data "aws_msk_cluster" "msk_cluster" {
  cluster_name = var.msk_cluster_name
}

data "aws_iam_role" "super_user" {
  name = var.iam_role_name
}

