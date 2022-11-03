
resource "aws_cloudwatch_dashboard" "EC2_Dashboard" {
  dashboard_name = "demo-server-Dashboard"
  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "${var.instance_id}" ]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "${var.current_region}",
                "period": 60,
                "stat": "Average"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 6,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "CWAgent", "disk_used_percent", "InstanceId", "${var.instance_id}"]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "${var.current_region}",
                "period": 60,
                "stat": "Average"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 12,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "CWAgent", "mem_used_percent", "InstanceId", "${var.instance_id}"]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "${var.current_region}",
                "period": 60,
                "stat": "Average"
            }
        }
    ]
}

EOF
}

  resource "aws_cloudwatch_metric_alarm" "cld" {
  alarm_name                = "cpu-utilization-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  #threshold_metric_id       = "e1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = [ "${aws_sns_topic.EC2_topic.arn}" ]
  alarm_actions             = [ "${aws_sns_topic.EC2_topic.arn}" ] 
  
  dimensions = {
  InstanceId = "${var.instance_id}"
 
  }
}

resource "aws_cloudwatch_metric_alarm" "memory" {
  alarm_name                = "memory-utilization-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "mem_used_percent"
  namespace                 = "CWAgent"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 memory utilization"
  insufficient_data_actions = [ "${aws_sns_topic.EC2_topic.arn}" ]
  alarm_actions             = [ "${aws_sns_topic.EC2_topic.arn}" ]

  dimensions = {
  InstanceId = "${var.instance_id}"
 
  }

}


resource "aws_cloudwatch_metric_alarm" "disk" {
  alarm_name                = "disk-utilization-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 disk utilization"
  insufficient_data_actions = [ "${aws_sns_topic.EC2_topic.arn}" ]
  alarm_actions             = [ "${aws_sns_topic.EC2_topic.arn}" ]

  dimensions = {
  InstanceId = "${var.instance_id}"
 
  }

}


resource "aws_sns_topic" "EC2_topic" {
  name = "Demo-server"
}

resource "aws_sns_topic_subscription" "EC2_Subscription" {
  topic_arn = aws_sns_topic.EC2_topic.arn
  protocol  = "email"
  endpoint  = "avinash@topsinfosolutions.com"

  depends_on = [
    aws_sns_topic.EC2_topic
  ]
}


/* metrics alarm for memory and disk usage*/

# resource "aws_cloudwatch_metric_alarm" "memory" {
#   alarm_name = "memory-utilization-alarm-${var.env}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "1"
#   metric_name = "mem_used_percent"
#   namespace = "CWAgent"
#   period = "300"
#   statistic = "Average"
#   threshold = "${var.alarms_memory_threshold}"
#   alarm_description = "This metric monitors ec2 memory utilization"
#   alarm_actions = [ "${aws_sns_topic.sns_topic.arn}" ]

#   dimensions = {
#     InstanceId = "${var.instance_id}"
#     ImageId = "${var.ami_id}"
#     InstanceType = "${var.instance_type}"
#   }

#   tags = {
#     Environment = "${var.env}"
#     Project = "${var.project}"
#     Provisioner="cloudwatch"
#     Name = "${local.name}.memory"
#   }
# }




/**------------------------------------------------------------------------------------**/

# # Creating the AWS CLoudwatch Alarm that will autoscale the AWS EC2 instance based on CPU utilization.
# resource "aws_cloudwatch_metric_alarm" "EC2_CPU_Usage_Alarm" {
#   # defining the name of AWS cloudwatch alarm
#   alarm_name          = "EC2_CPU_Usage_Alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   # Defining the metric_name according to which scaling will happen (based on CPU) 
#   metric_name = "CPUUtilization"
#   # The namespace for the alarm's associated metric
#   namespace = "AWS/EC2"
#   # After AWS Cloudwatch Alarm is triggered, it will wait for 60 seconds and then autoscales
#   period    = "60"
#   statistic = "Average"
#   # CPU Utilization threshold is set to 10 percent
#   threshold         = "80"
#   alarm_description = "This metric monitors ec2 cpu utilization exceeding 80%"
# }



# resource "aws_sns_topic" "EC2_topic" {
#   name = "EC2_topic"
# }

# resource "aws_sns_topic_subscription" "EC2_Subscription" {
#   topic_arn = aws_sns_topic.EC2_topic.arn
#   protocol  = "email"
#   endpoint  = "automateinfra@gmail.com"

#   depends_on = [
#     aws_sns_topic.EC2_topic
#   ]
# }


#   resource "aws_cloudwatch_log_group" "ebs_log_group" {
#     name = "ebs_log_group"
#     retention_in_days = 30
#   }


# resource "aws_cloudwatch_log_stream" "ebs_log_stream" {
#   name           = "ebs_log_stream"
#   log_group_name = aws_cloudwatch_log_group.ebs_log_group.name
# }

   
