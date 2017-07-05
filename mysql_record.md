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

3、查询优化相关
  1、find_in_set 比 in快
  2、like两边%没有使用索引，一边则使用到索引
  3、有时候连表中并没有取的字段，但where有用到时，可以控制是否要连此表(尽量减少连表)
