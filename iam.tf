provider "aws" {
    region     = "us-east-1"
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_iam_user" "example" {
  name  = var.user
}

resource "time_sleep" "wait_30_seconds" {
  
  depends_on = [aws_iam_user.example]

  create_duration = "30s"
}

variable "user" {
   default = "Newharnestest10"
}

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

output test {
 
  value = aws_iam_user.example.name
  depends_on = [time_sleep.wait_30_seconds]
}