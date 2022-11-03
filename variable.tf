# variable "instance_id" {
#   description = "Value of the Name tag for the EC2 instance"
#   type        = any
#   default     = "i-054fbee7c237c50cb"
# }

variable "instance_id" {
  description = "Value of the Name tag for the EC2 instance"
  type        = any
  default     = "i-0049daf69e5b06407"
  #always change default value after import or after creating new instance via terraform
}

variable "current_region" {
    description = "name of current region"
    type = any
    default = "us-east-2"
    # always recheck region and change region value as per requriment 
}