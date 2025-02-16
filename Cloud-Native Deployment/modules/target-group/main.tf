resource "aws_lb_target_group" "main" {
  name        = "demo-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}



