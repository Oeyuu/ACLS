resource "kafka_acl" "super_user_cluster_alter" {
  acl_principal       = "User:${var.super_user_sasl_username}"
  acl_host            = "*"
  acl_operation       = "Alter"
  acl_permission_type = "Allow"
  resource_type       = "Cluster"
  resource_name       = "kafka-cluster"
  lifecycle {
    prevent_destroy = true
  }
}

resource "kafka_acl" "super_user_cluster_alter_config" {
  depends_on          = [kafka_acl.super_user_cluster_alter]
  acl_principal       = "User${var.super_user_sasl_username}"
  acl_host            = "*"
  acl_operation       = "AlterConfigs"
  acl_permission_type = "Allow"
  resource_type       = "Cluster"
  resource_name       = "kafka-cluster"
  lifecycle {
    prevent_destroy = true
  }
}

resource "kafka_acl" "super_user_cluster_create" {
  depends_on          = [kafka_acl.super_user_cluster_alter_config]
  acl_principal       = "User${var.super_user_sasl_username}"
  acl_host            = "*"
  acl_operation       = "Create"
  acl_permission_type = "Allow"
  resource_type       = "Cluster"
  resource_name       = "kafka-cluster"
  lifecycle {
    prevent_destroy = true
  }
}

resource "kafka_acl" "super_user_cluster_describe" {
  depends_on          = [kafka_acl.super_user_cluster_create]
  acl_principal       = "User${var.super_user_sasl_username}"
  acl_host            = "*"
  acl_operation       = "Describe"
  acl_permission_type = "Allow"
  resource_type       = "Cluster"
  resource_name       = "kafka-cluster"
  lifecycle {
    prevent_destroy = true
  }
}

resource "kafka_acl" "super_user_cluster_describe_configs" {
  depends_on          = [kafka_acl.super_user_cluster_describe]
  acl_principal       = "User${var.super_user_sasl_username}"
  acl_host            = "*"
  acl_operation       = "DescribeConfigs"
  acl_permission_type = "Allow"
  resource_type       = "Cluster"
  resource_name       = "kafka-cluster"
  lifecycle {
    prevent_destroy = true
  }
}

resource "kafka_acl" "super_user_topics" {
  depends_on          = [kafka_acl.super_user_cluster_describe]
  acl_principal       = "User${var.super_user_sasl_username}"
  acl_host            = "*"
  acl_operation       = "All"
  acl_permission_type = "Allow"
  resource_type       = "Topic"
  resource_name       = "*"
  lifecycle {
    prevent_destroy = true
  }
}

resource "kafka_acl" "super_user_groups" {
  depends_on          = [kafka_acl.super_user_cluster_describe]
  acl_principal       = "User${var.super_user_sasl_username}"
  acl_host            = "*"
  acl_operation       = "All"
  acl_permission_type = "Allow"
  resource_type       = "Group"
  resource_name       = "*"
  lifecycle {
    prevent_destroy = true
  }
}
