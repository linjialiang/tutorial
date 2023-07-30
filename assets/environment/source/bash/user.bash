#!/usr/bin/env bash

WEB_USER = 'emad'
WEB_USER_GROUP = 'emad'

useradd -c 'developer user' -u 1001 -s /bin/zsh ${WEB_USER}
useradd -c 'PostgreSql service main process user' -u 2001 -s /bin/zsh pgsql
useradd -c 'redis service main process user' -u 2004 -s /usr/sbin/nologin redis
useradd -c 'nginx service work process user' -u 2002 -s /usr/sbin/nologin nginx
useradd -c 'php-fpm service work process user' -u 2003 -s /usr/sbin/nologin phpfpm

# usermod -G '' nginx
# usermod -G '' phpfpm
# usermod -G '' ${WEB_USER}
# usermod -G ${WEB_USER} nginx
# usermod -G ${WEB_USER} phpfpm
# usermod -G phpfpm ${WEB_USER_GROUP}
