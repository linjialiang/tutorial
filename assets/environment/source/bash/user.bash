#!/usr/bin/env bash

# 创建 开发 用户
groupadd -g 2000 emad
useradd -c 'developer user' -g emad -u 2000 -s /bin/zsh -m emad
cp -r /root/{.oh-my-zsh,.zshrc} /home/emad
chown emad:emad -R /home/emad/{.oh-my-zsh,.zshrc}

# 创建 postgres 用户
groupadd -g 2001 postgres
useradd -c 'postgres service main process user' -g postgres -u 2001 -s /sbin/nologin -m postgres
cp -r /root/{.oh-my-zsh,.zshrc} /home/postgres
chown postgres:postgres -R /home/postgres/{.oh-my-zsh,.zshrc}

# 创建 nginx 用户
groupadd -g 2003 nginx
useradd -c 'nginx service main process user' -g nginx -u 2003 -s /sbin/nologin -m nginx
cp -r /root/{.oh-my-zsh,.zshrc} /home/nginx
chown nginx:nginx -R /home/nginx/{.oh-my-zsh,.zshrc}

# 创建 php-fpm 用户
groupadd -g 2005 php-fpm
useradd -c 'php-fpm service main process user' -g php-fpm -u 2005 -s /sbin/nologin -m php-fpm
cp -r /root/{.oh-my-zsh,.zshrc} /home/php-fpm
chown php-fpm:php-fpm -R /home/php-fpm/{.oh-my-zsh,.zshrc}

# nginx 和 php-fpm 主进程非特权用户时，需要考虑如下问题：
# nginx 如果是通过 sock 文件代理转发给 php-fpm，php-fpm 主进程创建 sock 文件时需要确保 nginx 主进程用户有读写 sock 文件的权限
# 方式1：采用 sock 文件权限 php-fpm:nginx 660 (nginx 权限较少，php-fpm 权限较多)
usermod -G nginx php-fpm
# 方式2：采用 sock 文件权限 php-fpm:php-fpm 660 (nginx 权限较多，php-fpm 权限较少)
# usermod -G php-fpm nginx

# 部署环境注释，开发环境取消注释，用于开发用户追加附属组：
# usermod -a -G emad nginx
# usermod -a -G emad php-fpm
# usermod -G nginx,php-fpm,postgres emad

# # 创建 redis 用户
# groupadd -g 2002 redis
# useradd -c 'redis service main process user' -g redis -u 2002 -s /sbin/nologin -m redis
# cp -r /root/{.oh-my-zsh,.zshrc} /home/redis
# chown redis:redis -R /home/redis/{.oh-my-zsh,.zshrc}
#
# # 创建 MySQL 用户
# groupadd -g 2006 mysql
# useradd -c 'mysql service main process user' -g mysql -u 2006 -s /sbin/nologin -m mysql
# cp -r /root/{.oh-my-zsh,.zshrc} /home/mysql
# chown mysql:mysql -R /home/mysql/{.oh-my-zsh,.zshrc}
