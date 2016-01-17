nux写php扩展:
        PHP源码目录 /ext文件夹下执行: ./ext_skel --extname=my_ext就会生成文件夹my_ext;
        vi my_ext/my_ext.c 修改含有dnl的地方.大概是有3行,去掉"dnl"就可以了;
        可以再my_ext.c 文件中写自己的方法: PHP_FUNCTION(my_function){ #code }
        /phpize 执行编译
        ./configure --with-php-config=php-config
        make
        make install
        修改php.ini 添加my_ext.so扩展
        完成.

