#!/usr/bin/env bash

# mkdir.bash
func_create(){
    mkdir $1
}

server_array=(
    "/www"
    "/server"
    "/server/default"
    "/server/data"
    "/server/nginx"
    "/server/mysql"
    "/server/redis"
    "/server/sqlite3"
    "/server/php"
    "/server/php/80"
    "/server/php/81"
    "/server/php/82"
    "/server/run"
    "/server/run/nginx"
    "/server/run/redis"
    "/server/run/sqlite3"
    "/server/run/mysql"
    "/server/run/php"
    "/server/logs"
    "/server/logs/nginx"
    "/server/logs/redis"
    "/server/logs/sqlite3"
    "/server/logs/mysql"
    "/server/logs/php"
    "/server/sites"
    "/server/sites/ssl"
    "/server/tmp"
    "/server/tmp/nginx"
    "/server/tmp/redis"
    "/server/tmp/sqlite3"
    "/server/tmp/mysql"
    "/server/tmp/php"
    "/server/etc"
    "/server/etc/nginx"
    "/server/etc/redis"
    "/server/etc/sqlite3"
    "/server/etc/mysql"
    "/server/etc/php"
    "/server/etc/php/80"
    "/server/etc/php/81"
    "/server/etc/php/82"
)

package_array=(
    "/package"
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
