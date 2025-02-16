resource "aws_iam_policy" "alb_controller_policy" {
  name = "AWSLoadBalancerControllerIAMPolicy"

  policy = file("${path.module}/policies/alb-controller-policy.json")
}

resource "aws_iam_role" "alb_controller_role" {
  name = "${var.cluster_name}-alb-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.cluster_oidc_provider}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_alb_controller_policy" {
  policy_arn = aws_iam_policy.alb_controller_policy.arn
  role       = aws_iam_role.alb_controller_role.name
}

resource "null_resource" "deploy_alb_controller" {
  provisioner "local-exec" {
    command = <<EOT
      helm repo add eks https://aws.github.io/eks-charts
      helm repo update
      helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
        --namespace kube-system \
        --set clusterName=${var.cluster_name} \
        --set serviceAccount.create=false \
        --set serviceAccount.name=aws-load-balancer-controller \
        --set region=${var.region}
    EOT
  }

  triggers = {
    cluster_name = var.cluster_name
  }
}

