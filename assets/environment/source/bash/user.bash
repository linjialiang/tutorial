#!/usr/bin/env bash

WEB_USER='emad'
WEB_USER_GROUP='emad'
useradd -c 'developer user' -u 2000 -s /bin/zsh ${WEB_USER}
useradd -c 'This is the MySQL service user' -u 2001 -s /usr/sbin/nologin mysql
useradd -c 'redis service main process user' -u 2002 -s /usr/sbin/nologin redis
useradd -c 'nginx service work process user' -u 2003 -s /usr/sbin/nologin nginx
useradd -c 'php-fpm service work process user' -u 2005 -s /usr/sbin/nologin phpfpm
