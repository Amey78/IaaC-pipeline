# Create Application Load Balancer
resource "aws_lb" "main" {
  name               = "iaac-pipeline-alb"
  internal           = false
  load_balancer_type = "application"

  # Use two public subnets
  subnets = [
    var.public_subnet_1,
    var.public_subnet_2
  ]

  # Attach ALB security group
  security_groups = [var.alb_security_group_id]

  tags = {
    Name = "iaac-pipeline-alb"
  }
}
# Create target group for ECS containers
resource "aws_lb_target_group" "app" {
  name        = "iaac-pipeline-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  # Check application health
  health_check {
    path = "/"
  }

  tags = {
    Name = "iaac-pipeline-tg"
  }
}
# Listen for HTTP requests
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  # Forward requests to target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
