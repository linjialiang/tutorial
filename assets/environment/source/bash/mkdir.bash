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


    # "/server/redis"
    # "/server/redis/rdbData"
    # "/server/run/redis"
    # "/server/logs/redis"
    #
    # "/server/mysql"
    # "/server/data"
    # "/server/run/mysql"
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
