1、开防火墙端口
	firewall-cmd --zone=public --add-port=80/tcp --permanent
	iptables -I INPUT -p tcp --dport 80 -j ACCEPT

2、生成git ssh key
	ssh-keygen -t rsa -C "root@123.com"
	生成的*.pub 公钥添加到git上即可

3、postfix 发送邮件配置 (php使用mail函数)
	/etc/postfix/main.cf 中 修改 relayhost=[邮箱服务器ip] 
	重启postfix即可
	命令行发送邮件：
		echo "Subject: my subject" | sendmail -v to@123.com
		或者 sendmail -vt < mail.txt 
		mail.txt内容如下：
			To: to@123.com
			Subject: my subject
			From: from@123.com

4、

