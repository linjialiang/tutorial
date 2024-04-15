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

# 创建 redis 用户
groupadd -g 2002 redis
useradd -c 'redis service main process user' -g redis -u 2002 -s /sbin/nologin -m redis
cp -r /root/{.oh-my-zsh,.zshrc} /home/redis
chown redis:redis -R /home/redis/{.oh-my-zsh,.zshrc}

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

# 创建 MySQL 用户
groupadd -g 2006 mysql
useradd -c 'mysql service main process user' -g mysql -u 2006 -s /sbin/nologin -m mysql
cp -r /root/{.oh-my-zsh,.zshrc} /home/mysql
chown mysql:mysql -R /home/mysql/{.oh-my-zsh,.zshrc}
