resource "aws_lb_target_group" "my-target-group-http" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "main-tg-http"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}

#Certificate Needed
# resource "aws_lb_target_group" "my-target-group-https" {
#   health_check {
#     interval            = 10
#     path                = "/"
#     protocol            = "HTTPS"
#     timeout             = 5
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#   }

#   name        = "main-tg-https"
#   port        = 443
#   protocol    = "HTTPS"
#   target_type = "instance"
#   vpc_id      = aws_vpc.main.id
# }

resource "aws_lb" "my-aws-alb" {
  name     = "main-alb"
  internal = false

  security_groups = [
    aws_security_group.allow-ssh.id
  ]

  subnets = [
    aws_subnet.main-public-subnet.id,
    aws_subnet.main-public-subnet-1.id
  ]

  tags = {
    Name = "main-alb"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "main-alb-listner-http" {
  load_balancer_arn = aws_lb.my-aws-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-target-group-http.arn
  }
}


#Certificate Needed
# resource "aws_lb_listener" "main-alb-listner-https" {
#   load_balancer_arn = aws_lb.my-aws-alb.arn
#   port              = 443
#   protocol          = "HTTPS"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.my-target-group-https.arn
#   }
# }