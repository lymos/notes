# sql server record

1、查询所有数据库列表
	select * from sys.databases;

2、查询数据库下的所有表
	select * from sys.tables;

3、查询表字段信息
	sp_columns table_name;
	
4、限制查询条数
	select top num * from table;

5、identity_inster 提示，解决
	set identity_inster table on 

6、实现自增
	identity(1, 1) 从1开始自增1

7、获取最后插入的ID
 	insert into table (field) values (value) select last_insert_id=@@identity; 
 	
8、建立索引：
	create index index_name on table_name (field_name);

9、字段加备注:
	EXECUTE sp_addextendedproperty N'MS_Description', N'备注', N'user', N'dbo', N'table', N'表名', N'column', N'字段名';

10、表备注：
	EXECUTE sp_addextendedproperty N'MS_Description', N'备注', N'user', N'dbo', N'table', N'表名', NULL, NULL;

