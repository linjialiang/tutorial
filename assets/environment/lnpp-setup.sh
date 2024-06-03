#!/usr/bin/env bash

printf "\033c"

echo_cyan(){
  printf '\033[1;36m%b\033[0m\n' "$@"
}

echo_green(){
  printf '\033[1;32m%b\033[0m\n' "$@"
}

echo_red(){
  printf '\033[1;31m%b\033[0m\n' "$@"
}

echo_yellow(){
  printf '\033[1;33m%b\033[0m\n' "$@"
}

#清空原先数据
cleanOldData(){
  echo_yellow "=================================================================="
  echo_green "清理旧数据"
  echo_yellow "=================================================================="
  echo_cyan "清理systemctl单元"
  systemctl disable --now {postgres,nginx,php83-fpm}.service
  rm /lib/systemd/system/{postgres,nginx,php83-fpm}.service
  systemctl daemon-reload
  echo_cyan "清理旧目录 /server,/www 如果有重要数据请先备份"
  rm -rf /server /www
  echo_cyan "删除旧用户 nginx,postgres,php-fpm 如果有重要数据请先备份"
  userdel -r nginx
  userdel -r postgres
  userdel -r php-fpm
  groupdel nginx
  groupdel postgres
  groupdel php-fpm
}

#创建单个用户
createSingleUser(){
  uid=$1
  userName=$2
  gid=$3
  groupName=$4
  echo_green "创建 $userName 用户"
  groupadd -g $gid $userName
  useradd -c "$userName service main process user" -g $groupName -u $uid -s /sbin/nologin -m $userName
  cp -r /root/{.oh-my-zsh,.zshrc} /home/$userName
  chown $userName:$groupName -R /home/$userName/{.oh-my-zsh,.zshrc}
}

#创建用户
createUser(){
  echo_yellow "=================================================================="
  echo_green "创建nginx、php-fpm、Postgres的进程用户"
  echo_yellow "=================================================================="
  createSingleUser 2001 'nginx' 2001 'nginx'
  createSingleUser 2002 'postgres' 2002 'postgres'
  createSingleUser 2003 'php-fpm' 2003 'php-fpm'
  echo ' '
  echo_yellow "=================================================================="
  echo_green "处理php-fpm的socket文件授权问题"
  echo_yellow "当 php-fpm 主进程非特权用户时，需要考虑socket文件权限问题："
  echo_yellow "nginx 如果是通过 sock 文件代理转发给 php-fpm，php-fpm 主进程创建\n sock 文件时需要确保 nginx 子进程用户有读写 sock 文件的权限"
  echo_yellow " "
  echo_yellow "方式1：采用 sock 文件权限 php-fpm:nginx 660 \n(nginx 权限较少，php-fpm 权限较多)"
  echo_cyan "usermod -a -G nginx php-fpm"
  echo_yellow " "
  echo_yellow "方式2：采用 sock 文件权限 php-fpm:php-fpm 660 \n(nginx 权限较多，php-fpm 权限较少)"
  echo_cyan "usermod -a -G php-fpm nginx"
  echo_yellow " "
  echo_green "本地使用的是tcp转发，并不需要考虑socket文件转发相关的权限问题"
  echo_yellow "=================================================================="
}

#开发用户追加权限
devUserPower(){
  devUserName=$1
  echo_yellow "=================================================================="
  echo_green "开发用户追加权限"
  echo_yellow "web/php文件所属用户都是开发用户，所以nginx和php-fpm用户需要追加开发组"
  echo_yellow " "
  echo_red "部署环境请注释此函数，开发环境需要开启"
  echo_red "部署环境不需要开发用户，可直接使用 nginx 用户作为 ftp、ssh 等上传工具的用户"
  echo_yellow "=================================================================="
  usermod -a -G $devUserName nginx
  usermod -a -G $devUserName php-fpm
  usermod -G nginx,php-fpm,postgres $devUserName
}

#安装依赖包
installPackage(){
  echo_yellow "=================================================================="
  echo_green "安装依赖"
  echo_green "进行这一步操作的目的是安装启用nginx + php + Postgres时必备依赖项"
  echo_yellow "=================================================================="
  apt install -y gcc g++ make pkg-config clang llvm-dev autoconf \
  libsystemd-dev libcurl4-openssl-dev libxslt1-dev libxml2-dev libssl-dev libpam0g-dev \
  libgd-dev libgeoip-dev liblz4-dev libzstd-dev libreadline-dev libossp-uuid-dev \
  zlib1g-dev libsqlite3-dev libffi-dev libgmp-dev libonig-dev libsodium-dev \
  libyaml-dev libzip-dev libcapstone-dev libpq-dev librdkafka-dev
}

#安装预构建包
InstallBuild(){
  echo_yellow "=================================================================="
  echo_green "解压lnpp预构建包\n含两个目录"
  echo_yellow " "
  echo_cyan "/server"
  echo_cyan "/www"
  echo_yellow " "
  echo_green "预先编译成功的lnpp解压到服务器目录下"
  echo_yellow "=================================================================="
  tar -xJf ./lnpp.tar.xz -C /
}

#修改文件权限
modFilePower(){
  echo_yellow "=================================================================="
  echo_green "文件权限"
  echo_green "通常来讲压缩包里含的权限是正确的，这里重新执行一遍，更加稳妥"
  echo_yellow "=================================================================="
  echo_green "nginx文件权限"
  chown nginx:nginx -R /server/{nginx,sites}
  find /server/{nginx,sites} -type f -exec chmod 640 {} \;
  find /server/{nginx,sites} -type d -exec chmod 750 {} \;
  chmod 750 -R /server/nginx/sbin
  chown nginx:nginx -R /server/logs/nginx
  chmod 750 /server/logs/nginx

  echo_green "为nginx启用CAP_NET_BIND_SERVICE能力"
  echo_red "注：每次修改nginx执行文件权限，都需要重新启用该能力"
  setcap cap_net_bind_service=+eip /server/nginx/sbin/nginx

  echo_green "php文件权限"
  chown php-fpm:php-fpm -R /server/php /server/logs/php
  find /server/php /server/logs/php -type f -exec chmod 640 {} \;
  find /server/php /server/logs/php -type d -exec chmod 750 {} \;
  chmod 750 -R /server/php/83/bin /server/php/83/sbin
  echo_green "postgres文件权限"
  chown postgres:postgres -R /server/postgres /server/pgData /server/logs/postgres
  find /server/postgres /server/logs/postgres -type f -exec chmod 640 {} \;
  find /server/postgres /server/logs/postgres -type d -exec chmod 750 {} \;
  find /server/pgData /server/postgres/tls -type f -exec chmod 600 {} \;
  find /server/pgData -type d -exec chmod 700 {} \;
  chmod 750 -R /server/postgres/bin
}

#安装systemctl单元
InstallSystemctlUnit(){
  echo_yellow "=================================================================="
  echo_green "加入systemctl守护进程\n含systemctl unit文件"
  echo_yellow " "
  echo_cyan "/lib/systemd/system/{postgres,nginx,php83-fpm}.service"
  echo_yellow " "
  echo_green "支持开启自动启动服务，非常规终止进程会自动启动服务"
  echo_yellow "=================================================================="
  cp ./service/* /lib/systemd/system/
  systemctl daemon-reload
  systemctl enable --now {postgres,nginx,php83-fpm}.service
}

#清理旧数据
cleanOldData
echo ' '
#创建用户
createUser
echo ' '
#开发用户追加权限，部署环境请注释掉，emad是开发用户名
devUserPower 'emad'
echo ' '
#安装依赖包
installPackage
echo ' '
#解压lnpp预构建包到指定目录
InstallBuild
echo ' '
#修改文件权限
modFilePower
echo ' '
#安装systemctl单元
InstallSystemctlUnit
echo ' '
echo_yellow "=================================================================="
echo_green "针对 Postgres用户 修改操作系统打开最大文件句柄数"
echo_yellow "为防止重复插入，请在 /etc/security/limits.conf 文件的结尾手动添加\n如下两行代码："
echo_red "注：这里是手动操作哦！！！"
echo_yellow " "
echo_cyan "postgres  soft  nofile  65535"
echo_cyan "postgres  hard  nofile  65535"
echo_yellow " "
echo_green "进行这一步操作的目的是防止linux操作系统内打开文件句柄数量的限制，\n避免不必要的故障"
echo_yellow "=================================================================="
