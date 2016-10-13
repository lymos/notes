1、master slave config
	master: 
		my.cnf:
			server-id = 1
			log-bin = logbin.log
			expire_logs_days = 10
			max_binlog_size = 100M
			binlog_format = mixed
		grant replication slave,replication client on *.* to 'slave'@'192.168.10.245' identified by '123456'; 
	slave: 
		my.cnf:
			server-id = 2
			replicate-do-db=test   # 要同步的数据库

		change master to  master_host='192.168.1.112', master_user='slave', master_password='123456', master_log_file='mysql-test-bin.000022', master_log_pos=106;
		start slave

2、my.cnf中配置 skip-new 使optimize innodb 优化表生效

