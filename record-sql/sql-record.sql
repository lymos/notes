1、插入数据忽略重复记录(add unique key for table)
	insert ignore into table (fields) values (values),(values)......;

2、删除重复记录，保留最早记录(min ID)
	delete B from table as B left outer join (select min(id) as mid from table group by field1,field2...) as keeps on keeps.mid = B.id where keeps.mid is null;

3、查数据已逗号分隔
	select group_concat(id) from table;  # result like 001,002,003

4. mysql 执行sql脚本:
	mysql -uroot -p your database < script.sql
	或mysql> source script.sql

5. mysql 导入导出:
	导入: mysqldump -uroot -p your database < script.sql
	导出: mysqldump -uroot -p your database > script.sql

6. select into table2 from table1 与 insert into select table2 from table1 区别:
	前者table2必须不存在，不然会报错
 
7. 查出数据库中所有表：
	select table_name from information_scheam.table where table_scheam = "数据库名"

8. mysql sql_mode参数:
	show variable like "sql_mode%" ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
