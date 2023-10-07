---
title: 安装 Sqlite3
titleTemplate: 环境搭建教程
---

# 安装 Sqlite3

[sqlite3](https://www.sqlite.org) 是一款轻型数据库

:::tip sqlite3 的一些特点

1. sqlite3 不需要配置，不需要安装，也不需要管理员，最牛的是它没有服务器，仅是一个文件；

2. 数据库以文件形式保存在磁盘上，可以自由 COPY 使用；

3. 因为 sqlite3 没有服务器监听端口，所以不能像 mysql 一样通过 ip 和端口远程连接数据库。如果想远程访问数据库，只能通过数据库文件共享方式。

:::

## 构建安装

由于 sqlite3 并非主要数据库，所以我们这里只做最简单的构建

::: info 构建指令

```bash
cd /package/sqlite-autoconf-3430100/
./configure --prefix=/server/sqlite3
make
make install
```

:::

## 权限

::: code-group

```bash [部署]
chown root:root -R /server/sqlite3
find /server/sqlite3 -type f -exec chmod 640 {} \;
find /server/sqlite3 -type d -exec chmod 750 {} \;
chmod 750 -R /server/sqlite3/bin
```

```bash [开发]
chown root:emad -R /server/sqlite3
find /server/sqlite3 -type f -exec chmod 640 {} \;
find /server/sqlite3 -type d -exec chmod 750 {} \;
chmod 750 -R /server/sqlite3/bin
```

:::

到此，sqlite3 简单构建安装就完成了，不需要配置就可以使用
