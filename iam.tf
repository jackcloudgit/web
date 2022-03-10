resource "aws_iam_user" "example" {
  name  = var.user
}

variable "user" {
   default = "Newharnestest"
}

resource "time_sleep" "wait_30_seconds" {
  
  depends_on = [aws_iam_user.example]

  create_duration = "30s"
}

output test {
 
  value = aws_iam_user.example.name
  depends_on = [time_sleep.wait_30_seconds]


}