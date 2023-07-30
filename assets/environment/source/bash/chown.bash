#!/usr/bin/env bash
WEB_USER = 'emad'
WEB_USER_GROUP = 'emad'

# chown.bash
func_chown_nginx(){
    chown nginx:nginx $1
}

func_chown_phpfpm(){
    chown phpfpm:phpfpm $1
}

func_chown_pgsql(){
    chown pgsql:pgsql $1
}

func_chown_redis(){
    chown redis:redis $1
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

chown_pgsql_array=(
    "/server/run/pgsql"
    "/server/logs/pgsql"
);

chown_redis_array=(
    "/server/run/redis"
    "/server/logs/redis"
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

echo "-----开始设置 pgsql 用户权限目录-----"
for((i=0;i<${#chown_pgsql_array[*]};i++));
do
   echo ${chown_pgsql_array[i]}
   func_chown_pgsql ${chown_pgsql_array[i]}
done
echo "-----pgsql 用户权限目录设置结束-----"

echo "-----开始设置 redis 用户权限目录-----"
for((i=0;i<${#chown_redis_array[*]};i++));
do
   echo ${chown_redis_array[i]}
   func_chown_redis ${chown_redis_array[i]}
done
echo "-----redis 用户权限目录设置结束-----"

echo "-----开始设置 开发者 用户权限目录-----"
for((i=0;i<${#chown_www_array[*]};i++));
do
   echo ${chown_www_array[i]}
   func_chown_www ${chown_www_array[i]}
done
echo "-----开发者 用户权限目录设置结束-----"
