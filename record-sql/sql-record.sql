1、插入数据忽略重复记录(add unique key for table)
	insert ignore into table (fields) values (values),(values)......;

2、删除重复记录，保留最早记录(min ID)
	delete B from table as B left outer join (select min(id) as mid from table group by field1,field2...) as keeps on keeps.mid = B.id where keeps.mid is null;

3、查数据已逗号分隔
	select group_concat(id) from table;  # result like 001,002,003


