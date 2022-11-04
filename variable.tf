variable "instance_id" {
  description = "Value of the Name tag for the EC2 instance"
  type        = any
  default     = "i-0d16bdd18cb8dccc6"
  #always change default value after import or after creating new instance via terraform
}

variable "current_region" {
    description = "name of current region"
    type = any
    default = "us-east-2"
    # always recheck region and change region value as per requriment 
}