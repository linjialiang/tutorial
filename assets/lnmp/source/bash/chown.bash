#!/bin/bash

# chown.bash
func_chown_nginx(){
    chown nginx:nginx $1
}

func_chown_phpfpm(){
    chown phpfpm:phpfpm $1
}

func_chown_www(){
    chown www:www $1
}

chown_nginx_array=(
    "/server/run/nginx"
    "/server/logs/nginx"
);

chown_phpfpm_array=(
    "/server/run/php"
    "/server/logs/php"
);

chown_www_array=(
    "/server/www"
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

echo "-----开始设置 www 用户权限目录-----"
for((i=0;i<${#chown_www_array[*]};i++));
do
   echo ${chown_www_array[i]}
   func_chown_www ${chown_www_array[i]}
done
echo "-----www 用户权限目录设置结束-----"
