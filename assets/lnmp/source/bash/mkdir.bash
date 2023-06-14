#!/bin/bash

# mkdir.bash
func_create(){
    mkdir $1
}

server_array=(
    "/server"
    "/server/data"
    "/server/www"
    "/server/default"
    "/server/sites"
    "/server/nginx"
    "/server/php"
    "/server/php/74"
    "/server/php/80"
    "/server/php/81"
    "/server/php/82"
    "/server/redis"
    "/server/sqlite3"
    "/server/run"
    "/server/run/nginx"
    "/server/run/mysqld"
    "/server/run/redis"
    "/server/run/sqlite3"
    "/server/run/php"
    "/server/logs"
    "/server/logs/nginx"
    "/server/logs/mysqld"
    "/server/logs/redis"
    "/server/logs/sqlite3"
    "/server/logs/php"
    "/server/ssl"
)

package_array=(
    "/package"
    "/package/default"
    "/package/php_ext"
)

echo "-----开始创建server目录-----"
for((i=0;i<${#server_array[*]};i++));
do
   echo ${server_array[i]}
   func_create ${server_array[i]}
done
echo "-----server目录创建结束 -----"

echo "-----开始创建package目录-----"
for((i=0;i<${#package_array[*]};i++));
do
   echo ${package_array[i]}
   func_create ${package_array[i]}
done
echo "-----package目录创建结束-----"
