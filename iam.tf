resource "aws_iam_role" "iam-role" {
  name = "super_user_role"

  assume_role_policy = <<EOF
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "kafkaconnect.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "aws:SourceAccount": "143805577160"
        },
        "ArnLike": {
          "aws:SourceArn": "arn:aws:kafka:eu-central-1:143805577160:cluster/mskcluster/b9ccfbb6-69d3-4763-a8c5-80a7e7124097-8"
        }
      }
    }   
  ]
}
EOF
}

# locals {
#     msk_cluster_id = split("/", split(":", data.aws_msk_cluster.this.id)[5])[2]
#${data.aws_msk_cluster.msk_cluster.arn}
# }

resource "aws_iam_policy" "iam-policy" {
  name        = "super_user_role-policy"
  description = "A test policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "kms:*",
                "logs:*",
                "kafka-cluster:*"
            ],
            "Resource": [
                "arn:aws:kafka:eu-central-1:143805577160:cluster/mskcluster/b9ccfbb6-69d3-4763-a8c5-80a7e7124097-8",
                "arn:aws:kafka:eu-central-1:143805577160:topic/mskcluster/b9ccfbb6-69d3-4763-a8c5-80a7e7124097-8/*",
                "arn:aws:kafka:eu-central-1:143805577160:group/mskcluster/b9ccfbb6-69d3-4763-a8c5-80a7e7124097-8/*",
                "*"
            ]
        }
    ]
}
EOF
}


#                 "${replace(data.aws_msk_cluster.msk_cluster.arn, 'cluster', 'topic')}"                
#                 "arn:aws:kafka:eu-central-1:143805577160:*/mskcluster/b9ccfbb6-69d3-4763-a8c5-80a7e7124097-8",
#                 "arn:aws:kafka:eu-central-1:143805577160:*/mskcluster/b9ccfbb6-69d3-4763-a8c5-80a7e7124097-8/*"

resource "aws_iam_role_policy_attachment" "iam-policy" {
  role       = aws_iam_role.iam-role.name
  policy_arn = aws_iam_policy.iam-policy.arn
}
