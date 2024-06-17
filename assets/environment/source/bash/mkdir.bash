#!/usr/bin/env bash

# mkdir.bash
func_create(){
    mkdir $1
}

server_array=(
    "/www"
    "/server"
    "/server/default"
    "/server/logs"

    "/server/nginx"
    "/server/logs/nginx"

    "/server/php"
    "/server/php/83"
    "/server/logs/php"

    "/server/postgres"
    "/server/pgData"
    "/server/logs/postgres"
    "/server/logs/postgres/wal_archive"

    "/server/sites"
    "/server/sites/ssl"

    "/server/redis"
    "/server/redis/rdbData"
    "/server/logs/redis"

    # "/server/mysql"
    # "/server/data"
    # "/server/logs/mysql"
    # "/server/etc/mysql"
    # "/server/tmp/mysql"
)

echo "-----开始创建server目录-----"
for((i=0;i<${#server_array[*]};i++));
do
   echo ${server_array[i]}
   func_create ${server_array[i]}
done
echo "-----server目录创建结束 -----"
