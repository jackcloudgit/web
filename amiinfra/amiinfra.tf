provider "aws" {
    region     = "us-east-1"
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
}
variable "user" {
   default = "Newharnestest10"
}

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

################################################################################
# Auto Scaling Group
################################################################################

resource "aws_autoscaling_group" "asg_test" {
  name                      = "jackasgtest"
  max_size                  = 1
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 0
  force_delete              = true
  #launch_template           = "lt-0aa7ca64ae40d69a4"
  launch_template {
    id      = "lt-0aa7ca64ae40d69a4"
    version = 1
  }
  vpc_zone_identifier       = [aws_subnet.private[0].id, aws_subnet.private[1].id]
  target_group_arns         = [aws_lb_target_group.tgtest.arn]

  tag {
      key = "Name"
      value = "${var.name}-web"
      propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
  
   tag {
      key = "Name"
      value = "${var.name}-asg"
      propagate_at_launch = false
  }

}

output asg {
 
  value = aws_autoscaling_group.asg_test.name
  
}