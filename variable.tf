variable "vpc_cidr" {
  description = "My VPC CIDR .."
  type        = string
}

# Subnet variables
variable "subnet_cidr_a" {
  description = "My subnet_a cidr.."
  type        = string
}

variable "subnet_cidr_b" {
  description = "My subnet_b cidr.."
  type        = string
}

variable "subnet_cidr_c" {
  description = "My subnet_c cidr"
  type        = string
}

variable "subnet_cidr_d" {
  description = "My subnet_d cidr"
  type        = string
}

# Availability Zones
variable "subnet_az_a" {
  description = "My subnet_a az"
  type        = string
}

variable "subnet_az_b" {
  description = "My subnet_b az"
  type        = string
}

variable "subnet_az_c" {
  description = "My subnet_c az"
  type        = string
}

variable "subnet_az_d" {
  description = "My subnet_d az"
  type        = string
}

# Tags
variable "environment" {
  description = "My ENV"
  type        = string
}

variable "owner" {
  description = "My owner"
  type        = string
}

