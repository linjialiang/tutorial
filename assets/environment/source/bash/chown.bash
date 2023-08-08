#!/usr/bin/env bash
WEB_USER='emad'
WEB_USER_GROUP='emad'

func_chown_nginx(){
    chown root:root $1
}

func_chown_phpfpm(){
    chown root:root $1
}

func_chown_redis(){
    chown redis:redis $1
}

func_chown_mysql(){
    chown mysql:mysql $1
}

func_chown_www(){
    chown ${WEB_USER}:${WEB_USER_GROUP} $1
}

chown_nginx_array=(
    "/server/run/nginx"
    "/server/logs/nginx"
);

chown_phpfpm_array=(
    "/server/run/php"
    "/server/logs/php"
);

chown_redis_array=(
    "/server/run/redis"
    "/server/logs/redis"
);

chown_mysql_array=(
    "/server/mysql"
    "/server/data"
    "/server/run/mysql"
    "/server/logs/mysql"
    "/server/tmp/mysql"
    "/server/etc/mysql"
);

chown_www_array=(
    "/www"
);

echo "-----开始设置nginx用户权限目录-----"
for((i=0;i<${#chown_nginx_array[*]};i++));
do
   echo ${chown_nginx_array[i]}
   func_chown_nginx ${chown_nginx_array[i]}
done
echo "-----nginx用户权限目录设置结束-----"

echo "-----开始设置 phpfpm 用户权限目录-----"
for((i=0;i<${#chown_phpfpm_array[*]};i++));
do
   echo ${chown_phpfpm_array[i]}
   func_chown_phpfpm ${chown_phpfpm_array[i]}
done
echo "-----phpfpm 用户权限目录设置结束-----"

echo "-----开始设置 redis 用户权限目录-----"
for((i=0;i<${#chown_redis_array[*]};i++));
do
   echo ${chown_redis_array[i]}
   func_chown_redis ${chown_redis_array[i]}
done
echo "-----redis 用户权限目录设置结束-----"

echo "-----开始设置 mysql 用户权限目录-----"
for((i=0;i<${#chown_mysql_array[*]};i++));
do
   echo ${chown_mysql_array[i]}
   func_chown_mysql ${chown_mysql_array[i]}
done
echo "-----mysql 用户权限目录设置结束-----"

echo "-----开始设置 开发者 用户权限目录-----"
for((i=0;i<${#chown_www_array[*]};i++));
do
   echo ${chown_www_array[i]}
   func_chown_www ${chown_www_array[i]}
done
echo "-----开发者 用户权限目录设置结束-----"
