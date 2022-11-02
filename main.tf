
data "aws_instance" "foo" {
  instance_id = var.instance_id

}

resource "aws_instance" "this" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro" 
  iam_instance_profile = aws_iam_instance_profile.this.name
  user_data            = local.userdata
  tags                 = { Name = "gmt-server" }
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

