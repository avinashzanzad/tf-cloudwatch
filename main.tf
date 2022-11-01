
resource "aws_instance" "this" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro" 
  iam_instance_profile = aws_iam_instance_profile.this.name
  user_data            = local.userdata
  tags                 = { Name = "EC2-with-cw-agent" }
}


resource "aws_ssm_parameter" "cw_agent" {
  description = "Cloudwatch agent config to configure custom log"
  name        = "/cloudwatch-agent/config"
  type        = "String"
  value       = file("cw_agent_config.json")
}


locals {
  userdata = templatefile("user_data.sh", {
    ssm_cloudwatch_config = aws_ssm_parameter.cw_agent.name
  })
}








/******************************* ************************************************/

# resource "aws_security_group" "this" {
#   name        = "security-group-teraform"
#   description = "security-group-teraform"
#   vpc_id      = "vpc-07be8fe1a9f8a9a2c"

#   ingress {
#     description = "TLS from VPC"
#     #name     = "tcp"
#     from_port = 80
#     to_port   = 80
#     protocol  = "tcp"
#     # cidr_blocks = ["172.25.0.0/16"]

#   }

#   egress {
#     from_port = 0
#     to_port   = 65535
#     protocol  = "tcp"
#     # cidr_blocks = ["0.0.0.0/0"]
#   }
# }





