#!/bin/bash


nginx -t

echo "########################################"
echo "####         eljefe server          ####"
echo "####                                ####"
echo "########################################"

echo "Iniciando o cron..."
service cron start

echo "Iniciando o nginx..."
service nginx start
# nginx

tail -f /var/log/nginx/access.log

# echo "iniciando o syslog..."
# /etc/init.d/rsyslog start
# 
# echo "iniciando haproxy..."
# haproxy -f /etc/haproxy/haproxy.cfg
# 
# tail -f /var/log/haproxy_0.log