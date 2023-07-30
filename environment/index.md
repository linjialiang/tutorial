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
|   ├─ pgsql                pgSql的数据目录
|   |  ├─ data              pgSql的数据目录
|   |  └─ ...
|   |
|   ├─ php                  PHP 版本目录
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
|   |  ├─ pgsql            pgSql的run目录
|   |  ├─ redis            redis的run目录
|   |  ├─ sqlite3          sqlite3的run目录
|   |  ├─ php              php的run目录
|   |  └─ ...
|   |
|   ├─ default             缺省站点路径
|   |   ├─ phpinfo.php     phpinfo
|   |   ├─ index.php       缺省站点提示页面
|   |
|   ├─ sites               虚拟主机配置文件目录
|   |
|   ├─ logs                服务器相关日志文件目录
|   |  ├─ nginx            nginx日志目录
|   |  ├─ pgsql            pgSql日志目录
|   |  ├─ redis            redis日志目录
|   |  ├─ sqlite3          sqlite3日志目录
|   |  ├─ php              php日志目录
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
<<<@/assets/environment/source/bash/chown.bash [权限]
<<<@/assets/environment/source/bash/tar.bash [解压]
:::

## 安装包列表

::: details /package 目录

1. nginx-1.24.0.tar.gz
2. openssl-3.0.9.tar.gz
3. pcre2-10.42.tar.bz2
4. zlib-1.2.13.tar.gz
5. redis-7.0.12.tar.gz
6. sqlite-autoconf-3420000.tar.gz
7. PostgreSQL
8. php-8.2.8.tar.xz
9. php-8.1.21.tar.xz
10. php-8.0.29.tar.xz

:::

::: details /package/php_ext 目录

1. redis-5.3.7.tgz
2. xdebug-3.2.2.tgz

:::

::: tip 说明

- nginx 和 php-fpm 的主进程是 root
- redis、postgresql 的主进程可以自己设定用户

:::

## 用户说明

在用户脚本中我们可以看到，我们创建了 4 个用户

| 用户名 | 说明               |
| ------ | ------------------ |
| pgsql  | pgsql 主进程用户   |
| redis  | redis 主进程用户   |
| nginx  | nginx 子进程用户   |
| phpfpm | php-fpm 子进程用户 |
| www    | 操作文件用户       |

::: tip 操作文件用户
如果是在本机搭建环境，直接用你的登陆用户作为操作文件的用户即可
:::

### 用户职责

- pgsql 是数据库 PostgreSql 的用户
- nginx 是 nginx work 进程的 Unix 用户
- phpfpm 是 FPM 子进程的 Unix 用户
- www 是开发者操作项目资源、文件的用户

### 用户权限

::: code-group

```md [pgsql]
pgsql 只针对 PostgreSQL
```

```md [redis]
redis 只针对 redis
```

```md [nginx]
浏览器等客户端浏览网站时，服务器使用 nginx 用户，加载静态文件以及输出 php 动态生成的内容，
所以接收 php 输出的内容和静态文件均需提供 `读` 的权限;

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

### 1. 设置站点用户权限

```bash
# 设置站点用户
chown www:www -R /www/

# 设置站点文件权限
find /www/ -type f -exec chmod 640 {} \;

# 设置站点目录权限
find /www/ -type d -exec chmod 750 {} \;

# 站点上层目录
chown root:root /www/ # 用户及用户组设为 [root] 更加安全
chmod 755 /www/ # 权限设为 [755]
```

::: tip tp6 站点案例：

```bash
chown www:www -R /www/tp6/
# 正常文件权限设为640
find /www/tp6/ -type f -exec chmod 640 {} \;
find /www/tp6/ -type d -exec chmod 750 {} \;

# 需要 php-fpm 处理的目录权限设为 [770]
chmod 770 /www/tp6/runtime/ /www/tp6/public/static/upload/
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
