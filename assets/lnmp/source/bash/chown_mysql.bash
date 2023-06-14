#!/bin/bash

# chown_mysql.bash
func_chown_mysql(){
    chown mysql:mysql $1
}

chown_mysql_array=(
    "/server/data"
    "/server/run/mysqld"
    "/server/logs/mysqld"
);

echo "-----开始设置 mysql 用户权限目录-----"
for((i=0;i<${#chown_mysql_array[*]};i++));
do
   echo ${chown_mysql_array[i]}
   func_chown_mysql ${chown_mysql_array[i]}
done
echo "-----mysql 用户权限目录设置结束-----"
