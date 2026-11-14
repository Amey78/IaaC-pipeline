# Create ECS service to run application containers
resource "aws_ecs_service" "app" {
  name            = "iaac-pipeline-service${local.name_suffix}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"

  # Keep two containers running
  desired_count = 2

  # Deployment settings
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  # Run containers inside public subnets
  network_configuration {
    subnets = [
      var.public_subnet_1,
      var.public_subnet_2
    ]

    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = true
  }

  # Connect ECS containers to ALB
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app"
    container_port   = 80
  }

  health_check_grace_period_seconds = 60

  depends_on = [aws_lb_listener.http]
}
