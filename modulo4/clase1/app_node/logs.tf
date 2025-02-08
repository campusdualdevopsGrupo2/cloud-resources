resource "aws_cloudwatch_log_group" "node_task_log_group" {
  name = "/${local.tag_value}/ecs/node-task-logs"
  retention_in_days = 7  # Opcional: define la retención de logs
}
