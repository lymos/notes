# 删除重复的记录 保留最开始的一条
delete from erp_smt_message where (tokenID, type, channel_id, message_id) in (select tokenID, type, channel_id, message_id from 
erp_smt_message group by tokenID, type, channel_id, message_id having count(*) > 1 ) and id not in (select min(id) from erp_smt_message
 group by (tokenID, type, channel_id, message_id) having count(*) > 1;

####
DELETE MyTable 
FROM MyTable
LEFT OUTER JOIN (
   SELECT MIN(RowId) as RowId, Col1, Col2, Col3 
   FROM MyTable 
   GROUP BY Col1, Col2, Col3
) as KeepRows ON
   MyTable.RowId = KeepRows.RowId
WHERE
   KeepRows.RowId IS NULL

#### 删除重复的记录 保留最开始的一条 delete t1 from t2 删除多表记录
delete erp_smt_message from erp_smt_message left outer join (
	select min(id) as row_id from erp_smt_message group by tokenID,type,channel_id,message_id
	 ) as keeps on erp_smt_message.id = keeps.row_id where keeps.row_id is null;