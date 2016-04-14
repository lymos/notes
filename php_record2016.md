# php record

1、LDAP实现搜索
	$ds = ldap_connect($ldap_host, $ldap_port) or die("Could not connect to $ldaphost");
	// $Filter = "(&(cn=*)(cn=*" . urldecode($username) . "*))";    //按群组
    // $Filter = '(!(cn=$$_*))';
    $Filter = '(&(objectclass=dominoPerson)(!(location=*软件开发*))(!(location=信息系统部))(!(location=财务*)))';
    // 非关系: (!(表达式))
    // 与关系: (&(表达式)(表达式))

	if ($ds) {
        $r = ldap_bind($ds); // 匿名的 bind，为只读属性
        $sr =ldap_search($ds,$base_dn,$Filter); //dc=rmgab,dc=com这里，到底要写什么？这是我的域环境
        $info = ldap_get_entries($ds, $sr);
        for($i=0; $i<$info["count"]; $i++){
            echo "<user>". $info[$i]["cn"][0] ."</user>";
        }
        ldap_close($ds);
    }

2、使对象也可像数组一样进行foreach
    class object implements Iterator{
        private $_arr = array(1, 2, 3);

        // 实现PHP内置Iterator接口的方法
        public function rewind(){ return reset($this->_arr); }
        public function current(){ return current($this->_arr); }
        public function key(){ return key($this->_arr); }
        public function next(){ return next($this->_arr); }
        public function valid(){ return ($this->current() !== false); }
    }
    $obj = new object();
    foreach($obj as $key => $val){}

3、PHP精度问题
    intval((0.1 + 0.7) * 10) 结果会是7
    可以不用intval() 用round()

4、php 正则可执行匹配：(/e)
    preg_replace('/\d/e', '<?php echo 8; ?>', $string);
    就会执行echo 语句
   
5、处理并发、秒杀等同时多个请求：(避免库存为负)
    先加入到队列中，然后再逐个处理，排最后的就没有秒杀到；
    使用文件排他锁，flock锁定文件，如果锁定失败，表示有人在锁了，其他人就无法秒杀到；
    如果是操作数据库，可以在update时，控制好where ，使用事务操作等；
    数据库乐观锁，大致的意思是先查询库存，然后立马将库存+1，然后订单生成后，在更新库存前再查询一次库存，看看跟预期的库存数量是否保持一致，不一致就回滚，提示用户库存不足。



