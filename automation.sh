#!/bin/bash
s3_bucket=upgrad-saumya
sudo apt update -y
sudo apt-get install apache2
if [ $(/etc/init.d/apache2 status | grep -v grep | grep 'Apache2 is running' | wc -l) > 0 ]
then
 echo "Apache is running."
else
  echo "Apache is not running."
  sudo systemctl start apache2
fi
sudo update-rc.d apache2 enable
tar -zcf /tmp/saumya-httpd-logs-$(date '+%d%m%Y-%H%M%S').tar /var/log/apache2/*.log/apache2/*.log
sudo apt update
sudo apt install awscli
aws s3 \
cp /tmp/saumya-httpd-logs-$(date '+%d%m%Y-%H%M%S').tar \
s3://$(s3_bucket)/saumya-httpd-logs-$(date '+%d%m%Y-%H%M%S').tar
