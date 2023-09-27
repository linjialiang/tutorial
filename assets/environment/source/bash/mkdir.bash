#!/usr/bin/env bash

# mkdir.bash
func_create(){
    mkdir $1
}

server_array=(
    "/www"
    "/server"
    "/server/default"
    "/server/run"
    "/server/logs"
    "/server/etc"
    "/server/tmp"

    "/server/nginx"
    "/server/run/nginx"
    "/server/logs/nginx"

    "/server/redis"
    "/server/run/redis"
    "/server/logs/redis"

    "/server/sqlite3"
    "/server/run/sqlite3"
    "/server/logs/sqlite3"

    "/server/php"
    "/server/php/82"
    "/server/run/php"
    "/server/logs/php"

    "/server/mysql"
    "/server/data"
    "/server/etc/mysql"
    "/server/tmp/mysql"
    "/server/run/mysql"
    "/server/logs/mysql"

    "/server/data"
    "/server/etc/mysql"
    "/server/tmp/mysql"
    "/server/run/mysql"
    "/server/logs/mysql"

    "/server/sites"
    "/server/sites/ssl"
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
