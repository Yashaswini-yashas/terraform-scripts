#!/bin/bash
sudo yum update -y
sudo yum remove -y java
sudo yum install java-1.8.0-openjdk-devel -y
cd /tmp
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar -xvf nexus.tar.gz
sudo mv nexus-3* nexus
sudo adduser nexus
sudo chown -R nexus:nexus /tmp/nexus
sudo chown -R nexus:nexus /tmp/sonatype-work/
echo "run_as_user="nexus"" > /tmp/nexus/bin/nexus.rc
echo "
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/tmp/nexus/bin/nexus start
ExecStop=/tmp/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nexus.service

sudo chkconfig nexus on
systemctl enable nexus.service
sudo systemctl start nexus
