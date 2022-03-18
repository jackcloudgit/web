provider "aws" {
    region     = "us-east-1"
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
}

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "region" {
   default = "us-east-1"
}

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
  availability_zones       = ["us-east-1a"]
  launch_template {
    id      = "lt-0aa7ca64ae40d69a4"
    version = 1
  }
  
  tag {
      key = "Name"
      value = "web"
      propagate_at_launch = false
  }

  timeouts {
    delete = "15m"
  }
  
   tag {
      key = "Name"
      value = "asg"
      propagate_at_launch = false
  }

}

output asg {
 
  value = aws_autoscaling_group.asg_test.name
  
}


output region {
 
  value = var.region
  
}
