/*resource "aws_iam_policy" "this" {
  name        = var.policy_name
  description = var.policy_description
  policy      = var.policy_document
}



resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.managed_policy_arns[count.index]
}
*/
resource "aws_iam_role" "this" {
  name = "${var.tag_value}ecs-task-execution-role"

  # Política de asunción de rol genérica
  assume_role_policy = jsonencode(var.assume_role_policy)
}

resource "aws_iam_policy" "this" {
  name   = "${var.tag_value}ecs-task-execution-policy"
  policy = jsonencode(var.policy)
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

