1、master-slave(主从)
	主：mongod --config master.conf
	从：mongod --config slave.conf
	master.conf:
		dbpath = /data/db
		port = 27017
		bind_ip = 192.168.142.138
		master = true

	slave.conf:
		dbpath = /data/db
		port = 27017
		bind_ip = 192.168.142.139
		source = 192.168.142.138:27017 # 主服务器
		slave = true

	从服务器启动后，进入客户端执行： slave > rs.slaveOk() # allow queries on secondary nodes
	此从服务器不允许写操作


