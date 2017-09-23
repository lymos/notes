1、开防火墙端口
	firewall-cmd --zone=public --add-port=80/tcp --permanent
	iptables -I INPUT -p tcp --dport 80 -j ACCEPT

2、生成git ssh key
	ssh-keygen -t rsa -C "root@123.com"
	生成的*.pub 公钥添加到git上即可