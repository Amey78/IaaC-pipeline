# Store application logs in CloudWatch
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/iaac-pipeline"
  retention_in_days = 7

  tags = {
    Name = "iaac-pipeline-logs"
  }
}
