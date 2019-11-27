#!/bin/bash

uuid='23ad6b10-8d1a-40f7-8ad0-e3e35cd38297'
port=10086
alterId=64

config=/etc/v2ray/config.json

## Install V2ray
yum install -y epel-release vim wget unzip
wget https://raw.githubusercontent.com/gfw-breaker/gadgets/master/v2ray/v2ray-linux-64.zip
unzip v2ray-linux-64.zip
mkdir /usr/bin/v2ray
cp v2ray /usr/bin/v2ray/v2ray
cp v2ctl /usr/bin/v2ray/v2ctl
cp geoip.dat /usr/bin/v2ray/geoip.dat
cp geosite.dat /usr/bin/v2ray/geosite.dat
mkdir /etc/v2ray/
cp vpoint_vmess_freedom.json $config

if [ -f /v2ray-params ]; then
	source /v2ray-params
fi
sed -i "s/10086/$port/g" $config
sed -i "s/23ad6b10-8d1a-40f7-8ad0-e3e35cd38297/$uuid/g" $config
sed -i "s/: 64/: $alterId/g" $config


## Log
mkdir /var/log/v2ray/
touch /var/log/v2ray/access.log
touch /var/log/v2ray/error.log
touch /var/run/v2ray.pid
cp ./systemd/v2ray.service /usr/lib/systemd/system
systemctl enable v2ray
systemctl start v2ray
systemctl status v2ray


## Install BBR
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install kernel-ml -y

echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf

egrep ^menuentry /boot/grub2/grub.cfg | cut -f 2 -d \' 
grub2-set-default 0


