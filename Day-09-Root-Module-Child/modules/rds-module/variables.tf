variable "allocated_storage" {
  type = number
  default = 0
}

variable "identifier" {
  type = string
  default = ""
}

variable "db_name" {
  type = string
  default = ""
}

variable "engine" {
  type = string
  default = ""
}

variable "engine_version" {
  type = string
  default = ""
}

variable "instance_class" {
  type = string
  default = ""
}

variable "username" {
  type = string
  default = ""
}

variable "password" {
  type = string
  default = ""
}

variable "parameter_group_name" {
  type = string
  default = ""
}

variable "db_subnet_group_name" {
  type = string
  default = ""
}

variable "publicly_accessible" {
  type = bool
  default = false
}

variable "backup_retention_period" {
  type = number
  default = 0
}

variable "backup_window" {
  type = string
  default = ""
}

variable "monitoring_interval" {
  type = number
  default = 0
}

variable "maintenance_window" {
  type = string
  default = ""
}

# variable "provider" {
#   type = string
#   default = ""
# }

variable "vpc_security_group_ids" {
  type = list(string)
  default = []
}

variable "deletion_protection" {
  type = bool
  default = false
}
variable "skip_final_snapshot" {
  type = bool
  default = true
}

# variable "provider" {
#   type = bool
#   default = true
# }


