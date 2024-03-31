#!/usr/bin/env bash

WEB_USER='emad'
WEB_USER_GROUP='emad'
useradd -c 'developer user' -u 2000 -s /bin/zsh ${WEB_USER}
useradd -c 'nginx service work process user' -u 2003 -s /usr/sbin/nologin nginx
useradd -c 'php-fpm service work process user' -u 2005 -s /usr/sbin/nologin phpfpm

# 创建 postgres 用户
groupadd -g 2001 postgres
useradd -c 'postgres service main process user' -g postgres -u 2001 -s /sbin/nologin -m postgres
cp -r /root/{.oh-my-zsh,.zshrc} /home/postgres
chown postgres:postgres /home/postgres/{.oh-my-zsh,.zshrc}

# 创建 MySQL 用户
groupadd -g 2006 mysql
useradd -c 'mysql service main process user' -g mysql -u 2006 -s /sbin/nologin -m mysql
cp -r /root/{.oh-my-zsh,.zshrc} /home/mysql
chown mysql:mysql /home/mysql/{.oh-my-zsh,.zshrc}

# 创建 redis 用户
groupadd -g 2002 redis
useradd -c 'redis service main process user' -g redis -u 2002 -s /sbin/nologin -m redis
cp -r /root/{.oh-my-zsh,.zshrc} /home/redis
chown redis:redis /home/redis/{.oh-my-zsh,.zshrc}
