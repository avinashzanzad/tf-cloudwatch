#!/bin/bash
set -e

# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data-extra -s 2>/dev/console) 2>&1

# Make sure we have all the latest updates when we launch this instance
sudo apt update -y 
sudo apt list --upgradable
sudo apt upgrade -y

# Configure Cloudwatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
sudo apt install unzip
unzip AmazonCloudWatchAgent.zip
sudo ./install.sh


# Use cloudwatch config from SSM
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c ssm:${ssm_cloudwatch_config} -s

# update 
sudo apt update -y
echo 'Done initialization'

