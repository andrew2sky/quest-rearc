# AWS Region
variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "eu-west-1"
}

# Secret Word for ECS Container Environment Variable
variable "secret_word" {
  description = "The secret word to be used as an environment variable in the ECS task."
  type        = string
}

