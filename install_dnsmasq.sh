#!/bin/bash

yum install -y dnsmasq

cat > /etc/resolv.conf <<EOF
nameserver 127.0.0.1
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

cat > /etc/dnsmasq.conf <<EOF
listen-address=127.0.0.1
conf-dir=/etc/dnsmasq.d

## example: block 360.cn and all subdomains
address=/360.cn/127.0.0.1
EOF

systemctl enable dnsmasq
systemctl start dnsmasq

