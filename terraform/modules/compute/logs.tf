# Store application logs in CloudWatch
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/iaac-pipeline${local.name_suffix}"
  retention_in_days = 7

  tags = {
    Name = "iaac-pipeline-logs${local.name_suffix}"
  }
}
