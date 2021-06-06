#!/bin/bash

yum install -y dnsmasq

sed -i '1i\nameserver 127.0.0.1' /etc/resolv.conf

cat > /etc/dnsmasq.conf <<EOF
listen-address=127.0.0.1
conf-dir=/etc/dnsmasq.d

address=/360.cn/127.0.0.1
EOF

systemctl enable dnsmasq
systemctl start dnsmasq

