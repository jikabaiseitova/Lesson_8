resource "aws_lb" "alb" {
  name               = "${var.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
}

resource "aws_lb_listener" "alb_listener" {
  count = length(var.lb_listener_ports)

  load_balancer_arn = aws_lb.alb.arn
  port              = var.lb_listener_ports[count.index]
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[count.index].arn
  }
}

resource "aws_lb_target_group" "tg" {
  count       = length(var.lb_listener_ports)
  name_prefix = "tg"

  port        = var.lb_listener_ports[count.index]
  protocol    = "HTTP"
  vpc_id      = var.vpc
  target_type = "instance"
}
