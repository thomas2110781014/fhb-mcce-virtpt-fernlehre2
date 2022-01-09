variable "container_image" {
  type = string
}

variable "container_image_version" {
  type = string
}

variable "web_name" {
   type = string
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "min_instances" {
  type = number
  default = 1
}

variable "max_instances" {
  type = number
  default = 1
}

variable "desired_instances" {
  type = number
  default = 1
}
