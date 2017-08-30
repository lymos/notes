1、redis cluster
	2台机子至少3个节点，共6个节点 6000-6005
	600x.conf:
		bind 192.168.142.135
		port 600x
		pidfile 600x.pid
		cluster-enabled yes
		cluster-config-file nodes-600x.conf
		cluster-node-timeout 15000
		appendonly yes

	启动：
		redis-server 600x.conf

	启动cluster:
		redis-trib.rb(源码中) create --replicas 1 主(ip):600x(依次3个节点) 从(ip):600x(依次3个节点) 
		例如：
		redis-trib.rb create --replicas 1 192.168.142.135:6003 192.168.142.135:6004 192.168.142.135:6005 200.200.3.206:6000 200.200.3.206:6001 200.200.3.206:6002

2、删除多个
 	redis-cli keys keyword* | xargs redis-cli del
 	

