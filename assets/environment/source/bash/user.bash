#!/usr/bin/env bash

WEB_USER = 'emad'
WEB_USER_GROUP = 'emad'

useradd -c 'PostgreSql service user' -u 2001 -s /bin/bash pgsql
useradd -c 'nginx service user' -u 2002 -s /bin/bash nginx
useradd -c 'php-fpm service user' -u 2003 -s /bin/bash phpfpm
# 开发环境使用登陆用户账户即可，不需要 www 用户
# useradd -c 'site root dir' -u 1001 -s /usr/sbin/nologin -d /server/default -M -U www

usermod -G '' nginx
usermod -G '' phpfpm
usermod -G '' ${WEB_USER}

# usermod -G ${WEB_USER} nginx
# usermod -G ${WEB_USER} phpfpm
# usermod -G phpfpm ${WEB_USER_GROUP}
