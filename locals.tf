locals {
  ami_id = data.aws_ami.ourami.id
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  private_subnet_id = split(",",data.aws_ssm_parameter.private_subnet_ids.value)[0]
  private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_ids.value)

  public_subnet_id = split(",",data.aws_ssm_parameter.public_subnet_ids.value)[0]
  public_subnet_ids = split(",",data.aws_ssm_parameter.public_subnet_ids.value)

  backend-alb_listener_arn = data.aws_ssm_parameter.backend-alb_listener_arn.value
  frontend-alb_listener_arn = data.aws_ssm_parameter.frontend-alb_listener_arn.value
  alb_listener_arn = "${var.component}" == "frontend" ? local.frontend-alb_listener_arn : local.backend-alb_listener_arn

  sg_id = data.aws_ssm_parameter.sg_id.value

  tg_port = "${var.component}" == "frontend" ? 80 : 8080
  health_check_path = "${var.component}" == "frontend" ? "/" : "/health"

  rule_header_url = "${var.component}" == "frontend" ? "${var.environment}.${var.zone_name}" : "${var.component}.backend-${var.environment}.${var.zone_name}"

  common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = "true"
  }
}