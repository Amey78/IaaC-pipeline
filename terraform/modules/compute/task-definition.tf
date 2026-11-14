# Define how application container will run
resource "aws_ecs_task_definition" "app" {
  family                   = "iaac-pipeline-task${local.name_suffix}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  # CPU and memory for container
  cpu    = "256"
  memory = "512"

  # IAM role for ECS
  execution_role_arn = var.execution_role_arn

  # Container configuration
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${aws_ecr_repository.app.repository_url}:latest"
      essential = true

      # Application port
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]

      # Send logs to CloudWatch
      logConfiguration = {
        logDriver = "awslogs"

        options = {
          "awslogs-group"         = "/ecs/iaac-pipeline${local.name_suffix}"
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  # Create log group before registering task definition
  depends_on = [aws_cloudwatch_log_group.app]
}
