# apache httpd record
1、基于IP port 虚拟机配置，访问限制
	Listen 200.200.3.227:88	# 监听
	<VirtualHost 200.200.3.227:88>
	    # ServerAdmin webmaster@dummy-host2.example.com
	    DocumentRoot "d:/wamp/www/phpems"
	    ServerName 200.200.3.227
	    # ErrorLog "logs/dummy-host2.example.com-error.log"
	    # CustomLog "logs/dummy-host2.example.com-access.log" common
	    <Directory "d:/wamp/www/phpems">	# 目录
			Options all
			AllowOverride None
			Order Allow,Deny	# 允许 限制 的优先级
			Allow From All  	# 允许所有
			Deny From 200.200.3.227	 # 限制ip访问
			Deny From 127.0.0.1		# 限制ip访问
			......
		</Directory>
	</VirtualHost>

2、apache httpd 关闭服务器信息
	conf中 ServerToken Prod 
		   ServerSignature Off

2、Require local 只允许本地访问
   Require all denied 禁止所有访问
   Require all granted 允许所有访问
   Require ip 127.0.0.1 允许IP
   Require not 127.0.0.1 不允许IP

 
		   