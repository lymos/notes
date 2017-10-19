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

11、判断表是否存在：
	IF  EXISTS (select * from sysobjects where id = object_id(N'[table_name]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) drop table table_name;

12、建立group_contcat函数，返回逗号分隔
	create function dbo.group_concat_vgo_product(
		@gohome_id varchar(50)
	) 
	returns varchar(50)
	as BEGIN
		declare @r varchar(50)
		select @r = isnull(@r, '') + a.productline_id + ','
		from w_gohome_product as a 
		where a.gohome_id = @gohome_id
		return left(@r, len(@r) - 1)
	end




