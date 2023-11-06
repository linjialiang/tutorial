---
title: 概述
titleTemplate: 环境搭建教程
---

# 环境搭建概述

下面开始手工搭建 PHP 的开发环境、部署环境

## 测试环境

测试环境 `虚拟机` 的系统参数如下：

- 系统 :` Debian GNU/Linux 12 (Bookworm) x86_64`
- 内核 : `6.1.0-10-amd64`

::: details PHP 环境目录结构

```
====================================================
PHP 环境目录
====================================================
├─ /server                  服务目录
|   ├─ nginx                nginx
|   |  ├─ conf              nginx配置文件
|   |  └─ ...
|   |
|   ├─ mysql                mysql的基目录
|   |  └─ ...
|   |
|   ├─ data                 mysql的数据目录
|   |
|   ├─ php                  PHP 版本目录
|   |  ├─ 82                PHP8.2
|   |  └─ ...
|   |
|   ├─ sqlite3             sqlite3
|   |  └─ ...
|   |
|   ├─ redis               redis
|   |  └─ ...
|   |
|   ├─ run                 run
|   |  ├─ nginx            nginx的run目录
|   |  ├─ mysql            mysql的run目录
|   |  ├─ redis            redis的run目录
|   |  ├─ sqlite3          sqlite3的run目录
|   |  ├─ php              php的run目录
|   |  └─ ...
|   |
|   ├─ default             缺省站点路径
|   |   ├─ index.php       缺省站点提示页面
|   |
|   ├─ sites               虚拟主机配置文件目录
|   |
|   ├─ logs                服务器相关日志文件目录
|   |  ├─ nginx            nginx日志目录
|   |  ├─ mysql            mysql日志目录
|   |  ├─ redis            redis日志目录
|   |  ├─ sqlite3          sqlite3日志目录
|   |  ├─ php              php日志目录
|   |
|   ├─ tmp                 临时文件存放基目录
|   |  ├─ mysql            mysql的临时目录
|   |  ├─ ...
|   |
├─ /www                    站点根目录
|
└─
```

:::

## 脚本文件

我们准备了几个 bash 脚本文件：

::: code-group
<<<@/assets/environment/source/bash/user.bash [用户]
<<<@/assets/environment/source/bash/mkdir.bash [创建]
<<<@/assets/environment/source/bash/tar.bash [解压]
:::

## 安装包列表

::: details /package 目录

1. nginx-1.24.0.tar.gz
2. openssl-3.0.12.tar.gz
3. pcre2-10.42.tar.bz2
4. zlib-1.3.tar.xz
5. redis-7.2.3.tar.gz
6. sqlite-autoconf-3440000.tar.gz
7. php-8.2.12.tar.xz
8. mysql-boost-8.0.34.tar.gz

:::

::: details /package/php_ext 目录

1. apcu-5.1.22.tgz
2. mongodb-1.16.2.tgz
3. rdkafka-6.0.3.tgz
4. redis-6.0.2.tgz
5. xdebug-3.2.2.tgz
6. yaml-2.2.3.tgz

:::

::: tip 说明

- nginx、php-fpm、sqlite3 的主进程用户是 root
- redis、mysql 的主进程可以是指定的非特权用户

:::

## 用户说明

在用户脚本中我们可以看到，我们创建了 4 个用户

| 用户名 | 说明               |
| ------ | ------------------ |
| redis  | redis 主进程用户   |
| mysql  | mysql 主进程用户   |
| nginx  | nginx 子进程用户   |
| phpfpm | php-fpm 子进程用户 |
| www    | 操作文件用户       |

::: tip 操作文件用户
如果是在本机搭建环境，直接用你的登陆用户作为操作文件的用户即可
:::

### 用户职责

- nginx 是 nginx work 进程的 Unix 用户
- phpfpm 是 FPM 子进程的 Unix 用户
- www 是开发者操作项目资源、文件的用户

### 用户权限

::: code-group

```md [redis]
redis 只针对 redis
```

```md [nginx]
- 对静态文件需提供 `读` 的权限
- 对 php-fpm 的 `unix socket` 文件提供了读写的权限

浏览器等客户端使用 nginx 用户浏览网站：1)加载静态文件; 2) php-fpm 的 `unix socket` 文件传输

1. 使用 socket 转发，nginx 用户可作为 FPM 的监听用户，如：监听 socket、连接 web 服务器，权限设为 660
2. 使用 IP 转发，FPM 无需监听用户，nginx 用户需要
```

```md [phpfpm]
1. FPM 进程运行的 Unix 用户，对 php 脚本、php 所需的配置文件需要 `读` 的权限；
2. 当 php 需要操作文件或目录时，需要提供 `读+写` 权限：
   - 如：框架中记录运行时日志、缓存的 runtime 目录，就需要 `读+写` 全新
3. 除此以外，phpfpm 用户通常不需要其他权限
```

```md [www]
- 开发环境：需要对 php 文件、静态文件有 `读+写` 的权限;
- 部署环境：平时可以不提供任何权限，因为该用户与服务没有关联;
- 部署环境：对需要变动的文件，需要具有`读+写`的权限;

> 说明：如果开发环境在本机，直接使用登陆用户替代 www
```

:::

## 用户及用户组

下面这是开发环境的案例

### 1. 设置站点根目录权限

::: code-group

```bash [部署]
chown root:root /www
chmod 755 /www
```

```bash [开发]
chown emad:emad /www
chmod 755 /www
```

:::

### 2. tp 站点权限案例

::: code-group

```bash [权限分析]
- 对于php文件，phpfpm 需要读取权限
- 对于页面文件，nginx 需要读取权限
- 对于上传文件，phpfpm需要读写权限，nginx需要读取权限
- 对于缓存目录，phpfpm需要读写权限
- 对于入口文件，phpfpm需要读取权限, nginx不需要任何权限（直接走代理转发）
- 如果是开发环境，开发用户对所有文件都应该拥有读写权限
```

```bash [部署]
chown phpfpm:phpfpm -R /www/tp
find /www/tp -type f -exec chmod 440 {} \;
find /www/tp -type d -exec chmod 550 {} \;
# 部分目录需确保nginx可以访问和进入
chmod phpfpm:nginx -R /www/tp /www/tp/public /www/tp/public/static /www/tp/public/static/upload
# 部分文件需确保nginx可以访问
chmod 440 /www/tp/public/{favicon.ico,robots.txt}
# 缓存和上传目录需要写入权限
chmod 750 /www/tp/public/static/upload /www/tp/runtime
```

```bash [开发]
usermod -G emad phpfpm

chown emad:emad -R /www/tp
find /www/tp -type f -exec chmod 640 {} \;
find /www/tp -type d -exec chmod 750 {} \;
# 确保phpfpm和nginx可以访问public目录
chmod 755 /www/tp /www/tp/public /www/tp/public/static/
chmod 744 /www/tp/public/{favicon.ico,robots.txt}
# php读写 nginx读
chmod 775 /www/tp/public/static/upload
# php读写
chmod 770 /www/tp/runtime
```

:::

### 3. laravel 站点权限案例

::: code-group

```bash [权限分析]
- 对于php文件，phpfpm 需要读取权限
- 对于页面文件，nginx 需要读取权限
- 对于上传文件，phpfpm需要读写权限，nginx需要读取权限
- 对于缓存目录，phpfpm需要读写权限
- 对于入口文件，phpfpm需要读取权限, nginx不需要任何权限（直接走代理转发）
- 如果是开发环境，开发用户对所有文件都应该拥有读写权限
```

```bash [部署]
chown phpfpm:phpfpm -R /www/laravel
find /www/laravel -type f -exec chmod 440 {} \;
find /www/laravel -type d -exec chmod 550 {} \;
# 部分目录需确保nginx可以访问和进入
chmod phpfpm:nginx -R /www/laravel /www/laravel/public /www/laravel/public/static /www/laravel/public/static/upload
# 部分文件需确保nginx可以访问
chmod 440 /www/laravel/public/{favicon.ico,robots.txt}
# 缓存和上传目录需要写入权限
chmod 750 /www/laravel/public/static/upload
find /www/laravel/storage/ -type d -exec chmod 750 {} \;
```

```bash [开发]
usermod -G emad phpfpm

chown emad:emad -R /www/laravel
find /www/laravel -type f -exec chmod 640 {} \;
find /www/laravel -type d -exec chmod 750 {} \;
# 确保phpfpm和nginx可以访问public目录
chmod 755 /www/laravel /www/laravel/public /www/laravel/public/static/
chmod 644 /www/laravel/public/{favicon.ico,robots.txt}
# php读写 nginx读
chmod 775 /www/laravel/public/static/upload
# php读写
find /www/laravel/storage/ -type d -exec chmod 770 {} \;
chmod 750 /www/laravel/storage/
```

:::

::: danger 开发用户 umask 权限修改：

```bash
# ~/.profile
# 第9行 umask 022处新建一行
umask 027 # 创建的文件权限是 640 目录权限是 750
```

注意: `bash/zsh 配置文件` 开头需要增加一行：

```bash
# ~/.(bashrc|zshrc)
source ~/.profile
```

:::
