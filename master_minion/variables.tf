variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  default     = "ami-04b70fa74e45c3917"  # Example AMI, use an appropriate Ubuntu AMI
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  default     = "main-key"
}

variable "minion_count" {
  description = "Number of Salt minions to create"
  default     = 2
}
