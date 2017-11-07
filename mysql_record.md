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
			replicate-do-db=test2  # 要同步的第二个数据库

		change master to  master_host='192.168.1.112', master_user='slave', master_password='123456', master_log_file='mysql-test-bin.000022', master_log_pos=106;
		start slave
		重置 reset slave

2、my.cnf中配置 skip-new 使optimize innodb 优化表生效

3、查询优化相关
  1、find_in_set 比 in快
  2、like两边%没有使用索引，一边则使用到索引
  3、有时候连表中并没有取的字段，但where有用到时，可以控制是否要连此表(尽量减少连表)
  4、多表联合，同时有gourp by order by，他们的字段相同会用比较快
  5、union 比 or 快
  6、

4、数据库迁移直接复制data/ 下文件夹，ibdata1文件也复制即可

5、修复innodb my.cnf加参数 innodb_force_recovery = n(0-6)

6、slave跳过错误 my.cnf加 slave_skip_errors = 1062(错误代号)

7、mariadb cluster集群设定
	3台修改hosts 101 node1 102 node2 ...
	安装mariadb-galera数据库3台 IP: 101-103 
	开端口或者关防火墙
	安装 galera-3-25.3.21-2.el7.x86_64.rpm 用于服务提供者，见conf文件
	安装rsync 和 lsof (yum install即可)
	复制wsrep.conf到etc/my/cnf.d/下：
		wsrep_on=on (3台一样)
		wsrep_provider=libgalera_smm.so (galera-3-25.3.21-2.el7.x86_64.rpm安装路径中找) (3台一样)
		wsrep_cluster_address="gcomm://101,102,103" (3台一样)
		wsrep_node_address=101
		wsrep_sst_method=rsync (需要安装rsync)(3台一样)

	启动第1台 mysql.server start --wsrep_new_cluster(其他2台不需要此参数)
	验证：show status like 'wsrep_%'; 看参数
	完成

8、解锁只读表
  	flush tables with read lock;
  	unlock tables;

9、

