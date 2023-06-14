#!/bin/bash

# 开发环境
# useradd -c 'user name used in the Web development environment' -u 2001 -s /bin/bash
useradd -c 'This is the nginx service user' -u 2002 -s /usr/sbin/nologin -d /server/default -M -U nginx
useradd -c 'This is the php-fpm service user' -u 2003 -s /usr/sbin/nologin -d /server/default -M -U phpfpm

usermod -G '' nginx
usermod -G '' www
usermod -G '' phpfpm
usermod -G www,phpfpm nginx
usermod -G www phpfpm
usermod -G phpfpm www
