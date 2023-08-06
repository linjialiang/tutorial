---
title: 编译安装 MySQL
titleTemplate: 环境搭建教程
---

# {{ $frontmatter.title }}

MySQL 没有为 Debian12 做适配，所以最好的选择就是自己编译安装

## 下载源码包

![Mysql 源码包](/assets/environment/images/01.png)

::: tip 提示
如果没有特殊要求，建议下载 `mysql-boost-version.tar.gz` ，这是包含 `Boost(Includes Boost Headers)` 的源码包；

Boost 是一个 C++标准库，因为 mysql 主要是用 C++写的，它依赖于 C++标准库(即 Boost)；

如果下载的是不含`boost`的包，你还要自己去下载对应版本的 Boost，自己下载的 boost 版本未必能满足当前正在编译的 mysql 版本。
:::

## 编译前依赖准备

1. cmake
2. gcc
3. g++
4. openssl
5. Boost(一个 C++标准库，MySQL 包自带 Boost)；
6. ncurses 库
7. 充足的内存（最好有 2GB 以上的空闲内存，不够的话就添加虚拟内存）；
8. perl(不做 test 就不需要)。

```bash
apt update && apt install -y gcc g++ cmake
apt update && apt install -y libncursesada11-dev libtirpc-dev
```

## 创建用户

```bash
useradd -c 'This is the MySQL service user' -u 2005 -s /usr/sbin/nologin mysql
mkdir -p /server/mysql/data /server/run/mysql /server/logs/mysql
chown mysql:mysql /server/mysql/data
chown mysql:mysql /server/run/mysql
chown mysql:mysql /server/logs/mysql
```

## 编译

在不了解干什么的时候，尽量使用 MySQL 的默认值，并且 MySQL 很多参数都可以通过 my.ini 重新修改。

```bash
cd /package
tar -xzf mysql-boost-8.0.34.tar.gz
cd /package/mysql-8.0.34
mkdir /package/mysql-8.0.34/build
cd /package/mysql-8.0.34/build
cmake .. \
-DCMAKE_INSTALL_PREFIX=/server/mysql \
-DDOWNLOAD_BOOST=1 \
-DDOWNLOAD_BOOST_TIMEOUT=60 \
-DWITH_BOOST=/package/mysql-8.0.34/boost/boost_1_77_0 \
-DMYSQL_UNIX_ADDR=/server/run/mysql \
-DWITH_SSL=system \
-DWITH_SYSTEMD=1 \
-DSYSTEMD_PID_DIR=/server/run/mysql

cmake --build .
cmake --install .
```

### cmake 选项说明

| commom                     | note                                                |
| -------------------------- | --------------------------------------------------- |
| `-DCMAKE_INSTALL_PREFIX`   | MySQL 安装基目录                                    |
| `-DWITH_BOOST`             | 构建 MySQL 需要 Boost 库                            |
| `-DDOWNLOAD_BOOST`         | boost 查不到，是否下载 Boost 库                     |
| `-DDOWNLOAD_BOOST_TIMEOUT` | 下载 Boost 库的超时秒数                             |
| `-DMYSQL_UNIX_ADDR`        | 服务器侦听 socket 连接的 Unix Socket 绝对路径文件名 |
| `-DWITH_SSL`               | 启用 SSL 支持，`system` 是使用系统自带的 openssl    |
| `-DWITH_SYSTEMD`           | 是否启用 systemd 支持文件的安装                     |
| `-DSYSTEMD_PID_DIR`        | 由 systemd 管理时，创建 PID 文件的绝对路径文件名    |
| `-DMYSQL_DATADIR`          | MySQL 数据目录的位置                                |
| `-DSYSTEMD_SERVICE_NAME`   | 由 systemd 管理时，要使用的 MySQL 服务的名称        |
| `-DSYSCONFDIR`             | my.cnf 默认绝对路径文件名                           |

### 启用 systemd 支持文件

选项 `-DWITH_SYSTEMD=1` 用于启用 systemd 支持文件；

启用后将安装 systemd 支持文件，并且不再安装 `mysqld_safe` 和 `System V 初始化` 等脚本；

在 systemd 不可用的平台上，启用 WITH_SYSTEMD 会导致 CMake 出错。

## 配置

### systemd 单元

### 数据初始化

```bash
# root 有密码，并且标记为过期，非系统 root 用户登录，必须创建一个新密码
mysqld --defaults-file=/etc/mysql/my.cnf --initialize --user=mysql
# root 没有密码，如果要开启可插拔认证，选择没有密码
mysqld --defaults-file=/etc/mysql/my.cnf --initialize-insecure --user=mysql
```
