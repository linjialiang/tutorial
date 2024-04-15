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
    "/server/redis/rdbData"
    "/server/run/redis"
    "/server/logs/redis"

    "/server/php"
    "/server/php/83"
    "/server/run/php"
    "/server/logs/php"

    "/server/postgres"
    "/server/pgData"
    "/server/run/postgres"
    "/server/logs/postgres"

    "/server/sites"
    "/server/sites/ssl"
    
    "/server/mysql"
    "/server/data"
    "/server/run/mysql"
    "/server/logs/mysql"
    "/server/etc/mysql"
    "/server/tmp/mysql"
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
