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

#系统更新到最新
upgradeOS(){
  echo_yellow "=================================================================="
  echo_red    "请使用纯净版操作系统，否则可能会造成系统破坏和数据丢失!!!"
  echo_green  "操作前请将系统更新至最新，指令如下："
  echo_yellow "=================================================================="
  apt update
  apt full-upgrade -y
  echo_red "条件允许，建议重启系统"
}

#清空原先数据
cleanOldData(){
  echo_yellow "=================================================================="
  echo_green "清理旧数据"
  echo_yellow "=================================================================="
  echo_cyan "清理systemctl单元"
  systemctl disable --now {redis,postgres,nginx,php84-fpm,mysqld-84}.service
  rm /lib/systemd/system/{redis,postgres,nginx,php84-fpm,mysqld-84}.service
  systemctl daemon-reload
  echo_cyan "清理旧目录 /server,/www 如果有重要数据请先备份"
  rm -rf /server /www
  echo_cyan "删除旧用户 nginx,postgres,php-fpm,mysql,sqlite,redis 如果有重要数据请先备份"
  userdel -r nginx
  userdel -r postgres
  userdel -r php-fpm
  userdel -r redis
  userdel -r mysql
  userdel -r sqlite
  groupdel nginx
  groupdel postgres
  groupdel php-fpm
  groupdel redis
  groupdel mysql
  groupdel sqlite
}

#创建单个用户
createSingleUser(){
  userName=$1
  isSupportZsh=$2
  echo_green "创建 $userName 用户"
  groupadd $userName
  useradd -c "$userName service main process user" -g $userName -s /sbin/nologin -m $userName
  if [ "$isSupportZsh" -eq "1" ]; then
    cp -r /root/{.oh-my-zsh,.zshrc} /home/$userName
    chown $userName:$userName -R /home/$userName/{.oh-my-zsh,.zshrc}
  fi
}

#创建用户
createUser(){
  echo_yellow "=================================================================="
  echo_green "创建nginx、php-fpm、Postgres、Redis、SQLite3、MySQL的进程用户"
  echo_yellow "=================================================================="
  echo_red "必须root用户安装并配置成功zsh，才允许支持zsh"
  zshState=0
  echo_cyan "是否支持启用zsh(1支持，默认不支持)："
  read zshState
  createSingleUser 'nginx' $zshState
  createSingleUser 'postgres' $zshState
  createSingleUser 'php-fpm' $zshState
  createSingleUser 'redis' $zshState
  createSingleUser 'mysql' $zshState
  createSingleUser 'sqlite' $zshState
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
  echo ' '
  echo_yellow "=================================================================="
  echo_green "php编译pgsql扩展，使用指定Postgres安装目录时，需要提供读取libpq相关权限："
  echo_green "php编译sqlite3扩展，使用指定sqlite3自带的pkgconfig时，需要提供读取对应目录的权限："
  echo_cyan "usermod -a -G postgres,sqlite php-fpm"
  echo_green "如果使用 apt install libpq-dev -y 依赖包则不需要"
  echo_yellow " "
  echo_green "此版本使用指定Postgres安装目录以及自己编译的SQLite3"
  echo_yellow "=================================================================="
  usermod -a -G postgres,sqlite php-fpm
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
  usermod -a -G nginx,php-fpm,postgres,redis,mysql,sqlite $devUserName
}

#安装依赖包
installPackage(){
  echo_yellow "=================================================================="
  echo_green "安装依赖"
  echo_green "确保 nginx + php + Postgres + MySQL + Redis 必备依赖项"
  echo_green "debian12 发行版，如因依赖导致部分功能异常，自行安装相应依赖包即可"
  echo_red "注意1：该lnmpp包不兼容其他发行版，因为极有可能因为依赖问题，导致整个环境无法使用"
  echo_red "注意2：部分依赖包在部署阶段可能没用，但由于没对单个功能测试，只能选择安装全部依赖"
  echo_yellow "=================================================================="
  apt install -y gcc g++ clang make cmake pkg-config autoconf tcl libssl-dev \
  liblz4-dev libzstd-dev bison flex libreadline-dev zlib1g-dev libpam0g-dev \
  libxslt1-dev uuid-dev libsystemd-dev libldap-dev libsasl2-dev \
  libcurl4-openssl-dev libpng-dev libavif-dev libwebp-dev libjpeg-dev \
  libxpm-dev libfreetype-dev libgmp-dev libonig-dev libcapstone-dev \
  libsodium-dev libzip-dev libyaml-dev libgd-dev libgeoip-dev
}

#安装预构建包
InstallBuild(){
  echo_yellow "=================================================================="
  echo_green "解压lnmpp预构建包\n含两个目录"
  echo_yellow " "
  echo_cyan "/server"
  echo_cyan "/www"
  echo_yellow " "
  echo_green "预先编译成功的lnmpp解压到服务器目录下"
  echo_yellow "=================================================================="
  tar -xJf ./lnmpp.tar.xz -C /
}

#重置Redis数字证书
resetRedisCertificate(){
  rm -rf /server/redis/tls/
  echo_yellow "=================================================================="
  echo_green "创建一键生成redis数字证书脚本"
  echo_yellow " "
  echo_cyan "注意: 不能向其他用户开放权限"
  echo_cyan "开发环境: 目录 750/ 文件 640"
  echo_cyan "部署环境: 目录 700/ 文件 600"
  echo_yellow " "
  echo_green ""
  echo_yellow "=================================================================="
  echo_cyan "[+] Create Redis certs script..."
  tlsScriptPath=/server/redis/gen-test-certs.sh
  echo "#\!/bin/bash
generate_cert() {
    local name=\$1
    local cn=\"\$2\"
    local opts=\"\$3\"

    local keyfile=tls/\${name}.key
    local certfile=tls/\${name}.crt

    [ -f \$keyfile ] || openssl genrsa -out \$keyfile 2048
    openssl req \\
        -new -sha256 \\
        -subj \"/O=Redis Test/CN=\$cn\" \\
        -key \$keyfile | \\
        openssl x509 \\
            -req -sha256 \\
            -CA tls/ca.crt \\
            -CAkey tls/ca.key \\
            -CAserial tls/ca.txt \\
            -CAcreateserial \\
            -days 365 \\
            \$opts \\
            -out \$certfile
}

mkdir tls
[ -f tls/ca.key ] || openssl genrsa -out tls/ca.key 4096
openssl req \\
    -x509 -new -nodes -sha256 \\
    -key tls/ca.key \\
    -days 3650 \\
    -subj '/O=Redis Test/CN=Certificate Authority' \\
    -out tls/ca.crt

cat > tls/openssl.cnf <<_END_
[ server_cert ]
keyUsage = digitalSignature, keyEncipherment
nsCertType = server

[ client_cert ]
keyUsage = digitalSignature, keyEncipherment
nsCertType = client
_END_

generate_cert server \"Server-only\" \"-extfile tls/openssl.cnf -extensions server_cert\"
generate_cert client \"Client-only\" \"-extfile tls/openssl.cnf -extensions client_cert\"
generate_cert redis \"Generic-cert\"

[ -f tls/redis.dh ] || openssl dhparam -out tls/redis.dh 2048
" > $tlsScriptPath
  chmod +x $tlsScriptPath
  $tlsScriptPath
  echo_cyan "tls证书重置完成，是否删除一键生成Redis证书脚本(1删除/默认不删除)："
  read isDeleteCertificateScript
  if [ "$isDeleteCertificateScript" -eq "1" ]; then
    rm $tlsScriptPath
  fi
}

#重置PostgreSQL数字证书
resetPgsqlCertificate(){
  rm -rf /server/redis/tls/
  echo_yellow "=================================================================="
  echo_green "创建一键生成PostgreSQL数字证书脚本"
  echo_yellow " "
  echo_cyan "注意: 不能向其他用户开放权限"
  echo_cyan "开发环境: 目录 750/ 文件 640"
  echo_cyan "部署环境: 目录 700/ 文件 600"
  echo_yellow " "
  echo_green ""
  echo_yellow "=================================================================="
  echo_cyan "[+] Create PostgreSQL certs script..."
  tlsScriptPath=/server/postgres/gen-test-certs.sh
  echo "#\!/bin/bash
generate_cert() {
    local name=\$1
    local cn=\"\$2\"
    local opts=\"\$3\"

    local keyfile=tls/\${name}.key
    local certfile=tls/\${name}.crt

    [ -f \$keyfile ] || openssl genrsa -out \$keyfile 2048
    openssl req \\
        -new -sha256 \\
        -subj \"/O=PostgreSQL Test/CN=\$cn\" \\
        -key \$keyfile | \\
        openssl x509 \\
            -req -sha256 \\
            -CA tls/root.crt \\
            -CAkey tls/root.key \\
            -CAserial tls/root.txt \\
            -CAcreateserial \\
            -days 365 \\
            \$opts \\
            -out \$certfile
}

mkdir tls
[ -f tls/root.key ] || openssl genrsa -out tls/root.key 4096
openssl req \\
    -x509 -new -nodes -sha256 \\
    -key tls/root.key \\
    -days 3650 \\
    -subj '/O=PostgreSQL Test/CN=Certificate Authority' \\
    -out tls/root.crt

cat > tls/openssl.cnf <<_END_
[ server_cert ]
keyUsage = digitalSignature, keyEncipherment
nsCertType = server

[ client_cert ]
keyUsage = digitalSignature, keyEncipherment
nsCertType = client
_END_

generate_cert server \"Server-only\" \"-extfile tls/openssl.cnf -extensions server_cert\"
generate_cert client \"Client-only\" \"-extfile tls/openssl.cnf -extensions client_cert\"
generate_cert client-admin \"admin\" \"-extfile tls/openssl.cnf -extensions client_cert\"
generate_cert client-emad \"emad\" \"-extfile tls/openssl.cnf -extensions client_cert\"
generate_cert pgsql \"Generic-cert\"

[ -f tls/pgsql.dh ] || openssl dhparam -out tls/pgsql.dh 2048
" > $tlsScriptPath
  chmod +x $tlsScriptPath
  $tlsScriptPath
  rm $tlsScriptPath
  echo_cyan "tls证书重置完成，是否删除一键生成PostgreSQL证书脚本(1删除/默认不删除)："
  read isDeleteCertificateScript
  if [ "$isDeleteCertificateScript" -eq "1" ]; then
    rm $tlsScriptPath
  fi
}

#修改文件权限
modFilePower(){
  echo_yellow "=================================================================="
  echo_green "文件权限"
  echo_green "通常来讲压缩包里含的权限是正确的，这里重新执行一遍，更加稳妥"
  echo_yellow "=================================================================="
  echo_green "/server 目录权限"
  chown root:root -R /server
  chmod 755 /server
  find /server/default -type f -exec chmod 644 {} \;
  find /server/default -type d -exec chmod 755 {} \;

  echo_green "/www 目录权限"
  echo_red "开发环境使用emad用户（nginx/php-fpm 需加入 emad用户组）"
  echo_red "部署环境通常是www用户（nginx/php-fpm 需加入 www用户组）"
  chmod 750 /www

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

  echo_green "postgres文件权限"
  chown postgres:postgres -R /server/postgres /server/pgData /server/logs/postgres
  find /server/postgres /server/logs/postgres -type f -exec chmod 640 {} \;
  find /server/postgres /server/logs/postgres -type d -exec chmod 750 {} \;
  find /server/postgres/tls -type f -exec chmod 600 {} \;
  chmod 700 /server/pgData
  chmod o-rwx -R /server/pgData
  chmod g-w -R /server/pgData
  chmod 750 -R /server/postgres/bin

  echo_green "redis文件权限"
  chown redis:redis -R /server/redis /server/logs/redis
  find /server/redis /server/logs/redis -type f -exec chmod 640 {} \;
  find /server/redis /server/logs/redis -type d -exec chmod 750 {} \;
  chmod 750 -R /server/redis/bin

  echo_green "sqlite3文件权限"
  chown sqlite:sqlite -R /server/sqlite
  find /server/sqlite -type f -exec chmod 640 {} \;
  find /server/sqlite -type d -exec chmod 750 {} \;
  chmod 750 -R /server/sqlite/bin

  echo_green "MySQL文件权限"
  chown mysql:mysql -R /server/mysql /server/data /server/logs/mysql /server/etc/mysql
  find /server/mysql /server/logs/mysql /server/etc/mysql -type f -exec chmod 640 {} \;
  find /server/mysql /server/logs/mysql /server/etc/mysql -type d -exec chmod 750 {} \;
  chmod 700 /server/data
  chmod 750 -R /server/mysql/bin

  echo_green "php文件权限"
  chown php-fpm:php-fpm -R /server/php /server/logs/php
  find /server/php /server/logs/php /server/php/tools/ -type f -exec chmod 640 {} \;
  find /server/php /server/logs/php /server/php/tools/ -type d -exec chmod 750 {} \;
  chmod 750 -R /server/php/84/bin /server/php/84/sbin
  chmod 750 /server/php/84/lib/php/extensions/no-debug-non-zts-*/*
  chmod 750 /server/php/tools/composer.phar
}

#安装systemctl单元
InstallSystemctlUnit(){
  echo_yellow "=================================================================="
  echo_green "加入systemctl守护进程\n含systemctl unit文件"
  echo_yellow " "
  echo_cyan "/lib/systemd/system/{postgres,nginx,php84-fpm,redis}.service"
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

  echo_cyan "[+] Create php84-fpm service..."

  echo "[Unit]
Description=The PHP 8.4 FastCGI Process Manager
After=network.target

[Service]
Type=notify
User=php-fpm
Group=php-fpm
RuntimeDirectory=php84-fpm
RuntimeDirectoryMode=0750
ExecStart=/server/php/84/sbin/php-fpm --nodaemonize --fpm-config /server/php/84/etc/php-fpm.conf
ExecReload=/bin/kill -USR2 \$MAINPID
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
" >/lib/systemd/system/php84-fpm.service

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
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=mixed
KillSignal=SIGINT
TimeoutSec=infinity

[Install]
WantedBy=multi-user.target
" >/lib/systemd/system/postgres.service

  echo_cyan "[+] Create MySQL service..."

  echo "[Unit]
Description=MySQL Server 8.4.x
Documentation=man:mysqld(8)
After=network-online.target
Wants=network-online.target
After=syslog.target

[Service]
Type=notify
User=mysql
Group=mysql
RuntimeDirectory=mysql
RuntimeDirectoryMode=0750
ExecStart=/server/mysql/bin/mysqld --defaults-file=/server/etc/mysql/my.cnf
Restart=on-failure
PrivateTmp=false

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/mysqld-84.service

  echo_cyan "[+] Create redis service..."

  echo "[Unit]
Description=redis-7.4.x
After=network.target

[Service]
Type=forking
User=redis
Group=redis
RuntimeDirectory=redis
RuntimeDirectoryMode=0750
ExecStart=/server/redis/bin/redis-server /server/redis/redis.conf
ExecReload=/bin/kill -s HUP \$MAINPID
ExecStop=/bin/kill -s QUIT \$MAINPID
Restart=on-failure
PrivateTmp=true

[Install]
WantedBy=multi-user.target
" >/lib/systemd/system/redis.service

  echo_green "Registered Service..."
  systemctl daemon-reload
  systemctl enable --now {postgres,nginx,php84-fpm,redis,mysqld-84}.service
}

echo_cyan "解压脚本同级目录下需存在源码压缩包 lnmpp.tar.xz"
echo_cyan "是否退出(1退出/默认继续)："
read isExit
if [ "$isExit" -eq "1" ]; then
  exit 0
fi

#系统更新到最新
upgradeOS

echo_cyan "是否重启操作系统(1重启/默认不重启)："
read num

if [ "$num" -eq "1" ]; then
  echo_cyan "停止向下执行，并重启系统"
  sync;sync;sync;reboot
else
  #清理旧数据
  cleanOldData
  echo ' '
  #创建用户
  createUser
  echo ' '
  #开发用户追加权限，部署环境请注释掉
  echo_red "部署环境通常不需要授权"
  userName=''
  echo_cyan "输入开发用户名，为其授权(为空不授权)："
  read userName
  if [ ! -z '$userName' ]; then
    devUserPower $userName
  fi
  echo ' '
  #安装依赖包
  installPackage
  echo ' '
  #解压lnmpp预构建包到指定目录
  InstallBuild
  echo ' '
  #是否重新生成tls证书
  echo_cyan "是否重置数字证书(1重置/默认不重置)："
  read isResetCertificate
  if [ "$isResetCertificate" -eq "1" ]; then
    resetRedisCertificate
    resetPgsqlCertificate
  fi
  echo ' '
  #修改文件权限
  modFilePower
  echo ' '
  #安装systemctl单元
  InstallSystemctlUnit
  echo ' '
  echo_red "注：下面这些是手动操作哦！！！"
  echo_yellow "=================================================================="
  echo_green "针对 Postgres用户 修改操作系统打开最大文件句柄数"
  echo_yellow "为防止重复插入，请在 /etc/security/limits.conf 文件的结尾手动添加\n如下2行代码："
  echo_yellow " "
  echo_cyan "postgres  soft  nofile  65535"
  echo_cyan "postgres  hard  nofile  65535"
  echo_yellow " "
  echo_green "进行这一步操作的目的是防止linux操作系统内打开文件句柄数量的限制，\n避免不必要的故障"
  echo_yellow "=================================================================="
  echo ' '
  echo_yellow "=================================================================="
  echo_green "针对 redis 控制进程是否允许使用虚拟内存"
  echo_yellow "为防止重复插入，请在 /etc/sysctl.conf 文件的结尾手动添加如下1行代码："
  echo_yellow "   - 0：进程只能使用物理内存"
  echo_yellow "   - 1：进程可以使用比物理内存更多的虚拟内存"
  echo_yellow " "
  echo_cyan "vm.overcommit_memory = 1"
  echo_yellow " "
  echo_green "进行这一步操作的目的是防止redis在内存不足时，造成数据丢失"
  echo_yellow "=================================================================="
  echo ' '
  echo_yellow "=================================================================="
  echo_green "lnmpp安装完成！！！"
  echo_yellow "   - Postgres 默认有个超级管理员用户 admin 密码 1"
  echo_yellow "   - MySQL 默认有个超级管理员用户 admin@192.168.%.% 密码 1"
  echo_yellow "   - Redis 默认设置了全局密码 1"
  echo_yellow "=================================================================="
fi
