#!/bin/bash
sudo yum update -y
sudo yum remove -y java
sudo yum install java-1.8.0-openjdk-devel -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-6.4.zip
sudo unzip sonarqube-6.4.zip
cd sonarqube-6.4/bin/linux-x86-64/
sudo ./sonar.sh start
sudo ./sonar.sh status