data "aws_msk_cluster" "msk_cluster" {
  cluster_name = var.msk_cluster_name
}
