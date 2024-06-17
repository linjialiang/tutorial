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
  userName=$1
  groupName=$2
  echo_green "创建 $userName 用户"
  groupadd -g $userName
  useradd -c "$userName service main process user" -g $groupName -s /sbin/nologin -m $userName
}

#创建用户
createUser(){
  echo_yellow "=================================================================="
  echo_green "创建nginx、php-fpm、Postgres的进程用户"
  echo_yellow "=================================================================="
  createSingleUser 'nginx' 'nginx'
  createSingleUser 'postgres' 'postgres'
  createSingleUser 'php-fpm' 'php-fpm'
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
  echo_green "此版本使用的是tcp转发，并不需要考虑socket文件转发相关的权限问题"
  echo_yellow "=================================================================="
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

#安装systemctl单元
InstallSystemctlUnit(){
  echo_yellow "=================================================================="
  echo_green "加入systemctl守护进程\n含systemctl unit文件"
  echo_yellow " "
  echo_cyan "/lib/systemd/system/{postgres,nginx,php83-fpm}.service"
  echo_yellow " "
  echo_green "支持开启自动启动服务，非常规终止进程会自动启动服务"
  echo_yellow "=================================================================="
  echo_cyan "[+] Create nginx service..."

  echo "[Unit]
Description=nginx-1.26.x
After=network.target

[Service]
Type=forking
User=nginx
Group=nginx
RuntimeDirectory=nginx
RuntimeDirectoryMode=0750
ExecStartPre=/server/nginx/sbin/nginx -t
ExecStart=/server/nginx/sbin/nginx -c /server/nginx/conf/nginx.conf
ExecReload=/server/nginx/sbin/nginx -s reload
ExecStop=/server/nginx/sbin/nginx -s quit
Restart=on-failure
PrivateTmp=true

[Install]
WantedBy=multi-user.target
" >/lib/systemd/system/nginx.service

  echo_cyan "[+] Create php83-fpm service..."

  echo "[Unit]
Description=The PHP 8.3 FastCGI Process Manager
After=network.target

[Service]
Type=notify
User=php-fpm
Group=php-fpm
RuntimeDirectory=php83-fpm
RuntimeDirectoryMode=0750
ExecStart=/server/php/83/sbin/php-fpm --nodaemonize --fpm-config /server/php/83/etc/php-fpm.conf
ExecReload=/bin/kill -USR2 $MAINPID
PrivateTmp=true
ProtectSystem=full
PrivateDevices=true
ProtectKernelModules=true
ProtectKernelTunables=true
ProtectControlGroups=true
RestrictRealtime=true
RestrictAddressFamilies=AF_INET AF_INET6 AF_NETLINK AF_UNIX
RestrictNamespaces=true

[Install]
WantedBy=multi-user.target
" >/lib/systemd/system/php83-fpm.service

  echo_cyan "[+] Create postgres service..."

  echo "[Unit]
Description=PostgreSQL database server
Documentation=man:postgres(1)
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
User=postgres
Group=postgres
RuntimeDirectory=postgres
RuntimeDirectoryMode=0750
ExecStart=/server/postgres/bin/postgres -D /server/pgData
ExecReload=/bin/kill -HUP $MAINPID
KillMode=mixed
KillSignal=SIGINT
TimeoutSec=infinity

[Install]
WantedBy=multi-user.target
" >/lib/systemd/system/postgres.service

  echo_green "Registered Service..."
  systemctl daemon-reload
  systemctl enable --now {postgres,nginx,php83-fpm}.service
}

#修改文件权限
modFilePower(){
  echo_yellow "=================================================================="
  echo_green "文件权限"
  echo_yellow "=================================================================="
  echo_green "nginx文件权限"
  chown nginx:nginx -R /server/{nginx,sites}
  find /server/{nginx,sites} -type f -exec chmod 640 {} \;
  find /server/{nginx,sites} -type d -exec chmod 750 {} \;
  chmod 750 -R /server/nginx/sbin
  chown nginx:nginx -R /server/logs/nginx
  chmod 750 /server/logs/nginx

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

  echo_green "为nginx启用CAP_NET_BIND_SERVICE能力"
  echo_red "注：每次修改nginx执行文件权限，都需要重新启用该能力"
  setcap cap_net_bind_service=+eip /server/nginx/sbin/nginx
}

#清理旧数据
cleanOldData
echo ' '
#创建用户
createUser
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
echo_green "针对 Postgres用户 修改操作系统打开最大文件句柄数\n防止linux操作系统内打开文件句柄数量的限制，避免不必要的故障"
echo_yellow "为防止重复插入，请在 /etc/security/limits.conf 文件的结尾手动添加\n如下两行代码："
echo_red "注：这里是手动操作哦！！！"
echo_yellow " "
echo_cyan "postgres  soft  nofile  65535"
echo_cyan "postgres  hard  nofile  65535"
echo_yellow " "
echo_yellow "=================================================================="
echo ' '
echo_yellow "=================================================================="
echo_green "精简版不含开发者用户的权限授予，如有需要请自行授权："
echo_yellow " "
echo_cyan "usermod -a -G 开发组名 nginx"
echo_cyan "usermod -a -G 开发组名 php-fpm"
echo_cyan "usermod -G nginx,php-fpm,postgres 开发用户名"
echo_yellow " "
echo_yellow "=================================================================="
