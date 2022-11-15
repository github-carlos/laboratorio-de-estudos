
variable "aws_region" {
  type        = string
  description = "região aws"
  default     = "us-east-2"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "tf-carlos"
}

variable "aws_instance_ami" {
  type        = string
  description = ""
  default     = "ami-089a545a9ed9893b6"
}

variable "aws_instance_type" {
  type        = string
  description = ""
  default     = "t2.micro"
}