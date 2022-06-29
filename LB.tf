
# #------------ALB,NLB----------------
# # alb
# resource "aws_lb" "global-alb-web" {
#   name               = "global-alb-web"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.global-alb-sg-web.id]
#   subnets            = [aws_subnet.global-public-subnet-a.id, aws_subnet.global-public-subnet-c.id]
#   tags = {
#     Name = "global-alb-web"
#   }
# }

# # targetgroup
# resource "aws_lb_target_group" "global-targetgroup-web" {
#   name        = "global-targetgroup-web"
#   port        = "80"
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.global-vpc.id
#   target_type = "instance"
#   tags = {
#     Name = "global-targetgroup-web"
#   }
# }

# # listner
# resource "aws_lb_listener" "global-listner-web" {
#   load_balancer_arn = aws_lb.global-alb-web.arn
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.global-targetgroup-web.arn
#   }
# }

# # web attachement
# resource "aws_lb_target_group_attachment" "global-attachement-web1" {
#   target_group_arn = aws_lb_target_group.global-targetgroup-web.arn
#   target_id        = aws_instance.global-private-ec2-a-web.id
#   port             = 80
# }
# resource "aws_lb_target_group_attachment" "global-attachement-web2" {
#   target_group_arn = aws_lb_target_group.global-targetgroup-web.arn
#   target_id        = aws_instance.global-private-ec2-c-web.id
#   port             = 80
# }

# # alb sg
# resource "aws_security_group" "global-alb-sg-web" {
#   name        = "global-alb-sg-web"
#   description = "global-alb-sg-web"
#   vpc_id      = aws_vpc.global-vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "global-alb-sg-web"
#   }
# }
