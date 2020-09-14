variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "PUBLIC_SUBNET_CIDR" {
  default = "10.0.1.0/24"
}

variable "PUBLIC_SUBNET_CIDR_1" {
  default = "10.0.2.0/24"
}

variable "PRIVATE_SUBNET_CIDR" {
  default = "10.0.3.0/24"
}

variable "S3_FOLDER_NAME" {
  default = "images"
}