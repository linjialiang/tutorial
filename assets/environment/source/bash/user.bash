#!/usr/bin/env bash

useradd -c 'PostgreSql service user' -u 2001 -s /bin/bash pgsql
useradd -c 'nginx service user' -u 2002 -s /bin/bash nginx
useradd -c 'php-fpm service user' -u 2003 -s /bin/bash phpfpm
# 开发环境使用登陆用户账户即可，不需要 www 用户
# useradd -c 'site root dir' -u 1001 -s /usr/sbin/nologin -d /server/default -M -U www

# 部署环境
# usermod -G www,phpfpm nginx
# usermod -G www phpfpm
# usermod -G phpfpm www

# 开发环境 - www 用户使用 emad 替代
usermod -G emad,phpfpm nginx
usermod -G emad phpfpm
usermod -G phpfpm emad
