1、开防火墙端口
	firewall-cmd --zone=public --add-port=80/tcp --permanent
	iptables -I INPUT -p tcp --dport 80 -j ACCEPT

2、