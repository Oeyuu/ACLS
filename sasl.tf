
resource "random_password" "service" {
  length           = 20
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "service" {
  name                    = "AmazonMSK_${var.service}"
  kms_key_id              = data.aws_kms_key.msk.arn
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "service" {
  secret_id     = aws_secretsmanager_secret.service.id
  secret_string = jsonencode({ "username" : var.service, "password" : random_password.service.result })
}

resource "aws_secretsmanager_secret_policy" "service" {
  secret_arn = aws_secretsmanager_secret.super_user.arn
  policy     = data.aws_iam_policy_document.super_user.json
}

data "aws_iam_policy_document" "service" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["kafka.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["secretsmanager:getSecretValue"]
    resources = [aws_secretsmanager_secret.service.arn]
  }
}

resource "null_resource" "aws_msk_scram_secret_association" {
  depends_on = [aws_secretsmanager_secret.service]

  provisioner "local-exec" {
    when    = create
    command = "aws kafka batch-associate-scram-secret --cluster-arn ${data.aws_msk_cluster.msk_cluster.arn} --secret-arn-list ${aws_secretsmanager_secret.service.arn}"
  }
}

resource "null_resource" "aws_msk_scram_secret_disassociation" {
  triggers = {
    cluster-arn     = aws_msk_cluster.mskcluster.arn
    secret-arn-list = aws_secretsmanager_secret.service.arn
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws kafka batch-disassociate-scram-secret --cluster-arn ${self.triggers.cluster-arn} --secret-arn-list ${self.triggers.secret-arn-list}"
  }
}
