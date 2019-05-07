#!/bin/bash

#!/bin/bash

service iptables stop
chkconfig iptables off

echo nameserver 8.8.8.8 > /etc/resolv.conf
echo nameserver 8.8.4.4 >> /etc/resolv.conf

yum install -y git epel-release vim 

ip_addr=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)

# install open-proxy
git clone https://github.com/gfw-breaker/open-proxy.git
cd  /root/open-proxy
chmod +x *.sh
./install.sh


