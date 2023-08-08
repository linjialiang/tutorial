#!/usr/bin/env bash

WEB_USER='emad'
WEB_USER_GROUP='emad'
useradd -c 'developer user' -u 600 -s /bin/zsh ${WEB_USER}
useradd -c 'This is the MySQL service user' -u 601 -s /usr/sbin/nologin mysql
useradd -c 'redis service main process user' -u 602 -s /usr/sbin/nologin redis
useradd -c 'nginx service work process user' -u 603 -s /usr/sbin/nologin nginx
useradd -c 'php-fpm service work process user' -u 605 -s /usr/sbin/nologin phpfpm
