---
title: 概述
titleTemplate: 环境搭建教程
---

# 环境搭建概述

LNMP 是 PHP 首选的开发/部署环境，这里在 LNMP 的基础上增加更多的常用服务

## 测试环境

测试环境 `虚拟机` 的系统参数如下：

- 系统 :` Debian GNU/Linux 12 (Bookworm) x86_64`
- 内核 : `6.1.0-9-amd64`

::: details LNMP 目录结构

```
====================================================
LNMP 部署环境目录
====================================================
├─ /server                  LNMP 核心目录
|   ├─ nginx                nginx
|   |  ├─ conf              nginx配置文件
|   |  └─ ...
|   |
|   ├─ php                  PHP 版本目录
|   |  ├─ 74                PHP7.4
|   |  ├─ 80                PHP8.0
|   |  ├─ 81                PHP8.1
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
|   |  ├─ mysql            MySQL的run目录
|   |  ├─ redis            redis的run目录
|   |  ├─ sqlite3          sqlite3的run目录
|   |  ├─ php              php的run目录
|   |  └─ ...
|   |
|   ├─ default             缺省站点路径
|   |   ├─ pma             MySQL 管理工具
|   |   ├─ pra             Redis 管理工具
|   |   ├─ adminer.php     数据库管理工具
|   |   ├─ phpinfo.php     phpinfo
|   |   ├─ index.php       缺省站点提示页面
|   |
|   ├─ sites               虚拟主机配置文件目录
|   |
|   ├─ www                 站点根目录
|   |
|   ├─ data                MySQL的数据目录
|   |
|   ├─ logs                服务器相关日志文件目录
|   |  ├─ nginx            nginx日志目录
|   |  ├─ mysql            MySQL日志目录
|   |  ├─ redis            redis日志目录
|   |  ├─ sqlite3          sqlite3日志目录
|   |  ├─ php              php日志目录
|   |
|
└─
```

:::

开始构建环境前这里也为大家准备一些说明和辅助工具

## 脚本文件

这里准备了几个 bash 脚本文件

::: details 1. 创建脚本

- `/server/` : 存放运行 lnmp 时必要的数据和编译文件
- `/package/` : 下载的软件包，存放在这个目录下

<<<@/assets/lnmp/source/bash/mkdir.bash
:::

::: details 2. 权限脚本
<<<@/assets/lnmp/source/bash/chown.bash
:::

::: details 3. 源码压缩包解压脚本
<<<@/assets/lnmp/source/bash/tar.bash
:::

::: details 4. 删除脚本
<<<@/assets/lnmp/source/bash/delete.bash
:::

::: details 5. mysql 权限脚本
<<<@/assets/lnmp/source/bash/chown_mysql.bash
:::

::: details 6. 源码压缩包删除脚本
<<<@/assets/lnmp/source/bash/tar-delete.bash
:::

::: tip
mysql 用户默认不存在，需要成功安装 `MySQL` 后自动生成的
:::

::: details 6. 用户脚本
<<<@/assets/lnmp/source/bash/user.bash
:::

1. 执行 `mkdir.bash` 创建目录
2. 执行 `chown.bash` 为目录授权用户
3. 执行 `tar.bash` 解压压缩文件
4. 安装 mysql 后执行 `chown_mysql.bash` 为 mysql 相关目录授权用户
5. 执行脚本案例：

   ```bash
   chmod +x mkdir.bash
   bash mkdir.bash
   ```

## 安装包列表

这些软件包都是需要解压的，后面都会用到

::: details LNMP 包

目录： `/package`

1. nginx-1.24.0.tar.gz
2. openssl-3.0.9.tar.gz
3. pcre2-10.42.tar.bz2
4. zlib-1.2.13.tar.gz
5. redis-7.0.11.tar.gz
6. sqlite-autoconf-3420000.tar.gz
7. php-8.2.8.tar.xz
8. php-8.1.21.tar.xz
9. php-8.0.29.tar.xz

:::

::: details PHP 扩展

目录： `/package/php_ext`

1. apcu-5.1.22.tgz
2. redis-5.3.7.tgz
3. yaml-2.2.3.tgz
4. xdebug-3.2.1.tgz

:::

## 创建用户

### 1. 用户 `www`

```bash
# 部署环境，不允许登录
useradd -c 'specifies the username used in the Web deployment environment' -u 2001 -s /usr/sbin/nologin -d /server/default -M -U www

# 开发环境，可通过ssh登录
useradd www
```

::: tip 用户说明

1. 系统用户 www 是 web 站点的主用户
2. 开发环境，vscode 远程开发项目时，ssh 登录使用系统用户 www

:::

### 2. 用户 `nginx`

这是 `nginx` web 服务器的主用户

```bash
useradd -c 'This is the nginx service user' -u 2002 -s /usr/sbin/nologin -d /server/default -M -U nginx
```

### 3. 用户 `phpfpm`

这是 `php-fpm` 服务的主用户

```bash
useradd -c 'This is the php-fpm service user' -u 2003 -s /usr/sbin/nologin -d /server/default -M -U phpfpm
```

## 用户职责

上面这 3 个用户职责和权限是不同的

### 1. 用户职责：

::: info 用户 www

用户 www 主要是为开发者操作站点提供方便

1. 该用户与 nginx、phpfpm 服务本身并无关联;
2. 可作为 ftp/sftp 用户;
3. 客户端通过 vscode 远程开发主用户;
4. 客户端通过 samba 远程开发主用户;

:::

::: tip 用户 nginx

用户 nginx 是 `nginx web 服务` 的主用户

1. nginx 主管理用户;
2. 可作为 `php-fpm 服务` 的监听用户;

:::

::: danger 用户 phpfpm

用户 phpfpm 是 `php-fpm 服务` 的主用户

:::

### 2. 用户权限：

::: info 用户 www

- 开发环境：需要对 php 文件、静态文件有 `读+写` 的权限;
- 部署环境：平时可以不提供任何权限，因为该用户与服务没有关联;
- 部署环境：对需要变动的文件，需要具有`读+写`的权限;

:::

::: tip 用户 nginx

- 作为 web 服务主用户：浏览器等客户端访问网站，使用该用户的权限，所以对网页静态文件需要提供 `读` 的权限;
- 作为 php-fpm 服务的监听用户：需要读取后端文件，所以对 php 文件需要有 `读` 的权限

:::

::: danger 用户 phpfpm

1.  该用户通常对文件不需要任何权限;
2.  当 php 需要操作文件或目录时就必须提供 `读+写` 权限：

    - 比如：使用 php：创建、修改、删除文件或文件夹等，就必须提供 `读+写` 的权限;
    - 比如：使用 php：查看文件或文件夹列表，就必须提供 `读` 的权限;

> 提示：php-fpm 服务需要的内容都是通过其监听用户(nginx)读取的

:::

## 用户及用户组

### 1. 设置站点用户权限

```bash
# 设置站点用户
chown www:www -R /server/www/

# 设置站点文件权限
find /server/www/ -type f -exec chmod 640 {} \;

# 设置站点目录权限
find /server/www/ -type d -exec chmod 750 {} \;

# 站点上层目录
chown root:root /server/www/ # 用户及用户组设为 [root] 更加安全
chmod 755 /server/www/ # 权限设为 [755]
```

::: tip tp6 站点案例：

```bash
chown www:www -R /server/www/tp6/
# 正常文件权限设为640
find /server/www/tp6/ -type f -exec chmod 640 {} \;
find /server/www/tp6/ -type d -exec chmod 750 {} \;

# 需要 php-fpm 处理的目录权限设为 [770]，如果 [用户www] 没有加入 [用户组phpfpm] 为了查看方便，权限需要设为 [777]
chmod 770 /server/www/tp6/runtime/ /server/www/tp6/public/static/upload/
```

:::

### 2. 加入用户组

```bash
# 清空用户的附加用户组
usermod -G '' www
usermod -G '' nginx
usermod -G '' phpfpm

# 为用户添加附加用户组

# 用户 nginx 针对[静态文件]、[php文件]、[php程序创建的文件]，都需要具有读取权限
usermod -G www,phpfpm nginx
# [用户phpfpm] 通常需要加入 [用户组www]，需要php操作文件或目录时，上级目录权限设为 [770] 即可
usermod -G www phpfpm
# [用户www] 加入 [用户组phpfpm] 是为了在使用ftp、vscode远程开发这些工具时，方便查看php生成的文件
usermod -G phpfpm www
```

::: info 说明
如果用户已经有附加用户组,就需要使用 `-a` 指令，否则会覆盖之前全部用户组

`用户phpfpm` 也可以不加入其他用户组，这时需要 php 操作文件或目录时，上级目录权限需设为 `[777]`
:::

::: warning

更多用户权限请查看 debian 相关章节

:::
