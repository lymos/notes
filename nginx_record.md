# nginx record
1、https 配置:
默认情况下ssl模块并未被安装，如果要使用该模块则需要在编译时指定–with-http_ssl_module参数，安装模块依赖于OpenSSL库和一些引用文件，通常这些文件并不在同一个软件包中。通常这个文件名类似libssl-dev。
生成证书

可以通过以下步骤生成一个简单的证书：
首先，进入你想创建证书和私钥的目录，例如：

    $ cd /usr/local/nginx/conf

创建服务器私钥，命令会让你输入一个口令：

    $ openssl genrsa -des3 -out server.key 1024

创建签名请求的证书（CSR）：

    $ openssl req -new -key server.key -out server.csr

在加载SSL支持的Nginx并使用上述私钥时除去必须的口令：

    $ cp server.key server.key.org
    $ openssl rsa -in server.key.org -out server.key

配置nginx

最后标记证书使用上述私钥和CSR：

    $ openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

修改Nginx配置文件，让其包含新标记的证书和私钥：

    server {
        server_name YOUR_DOMAINNAME_HERE;
        listen 443;
        ssl on;
        ssl_certificate /usr/local/nginx/conf/server.crt;
        ssl_certificate_key /usr/local/nginx/conf/server.key;
    }

重启nginx。
这样就可以通过以下方式访问：

https://YOUR_DOMAINNAME_HERE

另外还可以加入如下代码实现80端口重定向到443IT人乐园

    server {
    listen 80;
    server_name ww.centos.bz;
    rewrite ^(.*) https://$server_name$1 permanent;
    }


2、命令行查看并发情况：
    netstat -n | awk '/^tcp/ {++state[$NF]} END {for(key in state) print key,"t",state[key]}'
    CLOSED  //无连接是活动的或正在进行
    LISTEN  //服务器在等待进入呼叫
    SYN_RECV  //一个连接请求已经到达，等待确认
    SYN_SENT  //应用已经开始，打开一个连接
    ESTABLISHED  //正常数据传输状态/当前并发连接数
    FIN_WAIT1  //应用说它已经完成
    FIN_WAIT2  //另一边已同意释放
    ITMED_WAIT  //等待所有分组死掉
    CLOSING  //两边同时尝试关闭
    TIME_WAIT  //另一边已初始化一个释放
    LAST_ACK  //等待所有分组死掉

3、使用代理实现web集群
    nginx.conf配置：
    upstream demo.com {
        server server1.com weight=2; // 分配权重 宕机后不分配
        server server2.com weight=2;
        ...
        ...
    }

    location / {
        proxy_pass demo.com;
        proxy_redirect default;
    }