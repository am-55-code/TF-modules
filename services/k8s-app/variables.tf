variable "name" {
  description = "The name to use for all resources created by this module"
  type        = string
}

variable "image" {
  description = "Docker Image to run"
  type        = string
}

variable "container_port" {
  description = "Port the Docker image listens on"
  type        = number
}

variable "replicas" {
  description = "How many replicas to run"
  type        = number
}

variable "environment_variables" {
  description = "Environment variables to set for the application"
  type        = map(string)
  default     = {}
}