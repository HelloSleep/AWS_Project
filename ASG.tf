
# #--------------ASG--------------------
# #web시작구성
# resource "aws_launch_configuration" "web_launch" {
#   image_id        = var.launch_web
#   instance_type   = "t2.micro"
#   security_groups = [aws_security_group.global-private-sg-web.id]

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # #web-autoscailing
# # resource "aws_autoscaling_group" "web_asg" {
# #   launch_configuration = aws_launch_configuration.web_launch.name
# #   vpc_zone_identifier  = [aws_subnet.global-private-subnet-a-web.id, aws_subnet.global-private-subnet-c-web.id]
# #   target_group_arns    = [aws_lb_target_group.global-targetgroup-web.arn]
# #   health_check_type    = "ELB"

# #   min_size = var.min_size
# #   max_size = var.max_size

# #   tag {
# #     key                 = "Name"
# #     value               = "global-asg-web"
# #     propagate_at_launch = true
# #   }
# # }
# # # ASG scheduling resource
# # resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
# #   count = var.enable_autoscaling ? 1:0

# #   scheduled_action_name = "scale-out-during-business-hours"
# #   min_size              = 2
# #   max_size              = 10
# #   desired_capacity      = 10
# #   recurrence            = "0 20 * * *"

# #   autoscaling_group_name = aws_autoscaling_group.example.name
# # }
# # resource "aws_autoscaling_schedule" "scale_out_during_anniversary" {
# #   count = var.enable_autoscaling ? 1:0

# #   scheduled_action_name = "scale-in-at-night"
# #   min_size              = 2
# #   max_size              = 10
# #   desired_capacity      = 2
# #   recurrence            = "* * 24-31 10 *"

# #   autoscaling_group_name = aws_autoscaling_group.example.name
# # }
# # resource "aws_autoscaling_schedule" "scale_out_during_anniversary" {
# #   count = var.enable_autoscaling ? 1:0

# #   scheduled_action_name = "scale-in-at-night"
# #   min_size              = 2
# #   max_size              = 10
# #   desired_capacity      = 10
# #   recurrence            = "* * 24-31 10 *"

# #   autoscaling_group_name = aws_autoscaling_group.example.name
# # }
