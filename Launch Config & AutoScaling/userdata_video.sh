#!/bin/bash
sudo yum install -y httpd
cd /var/www/html
sudo wget https://devops16-project-bucket.s3.amazonaws.com/videos/beautiful-video.mp4
sudo wget https://devops16-project-bucket.s3.amazonaws.com/videos/index.html
sudo systemctl enable httpd --now