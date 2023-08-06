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
5. Boost(一个 C++标准库，我们下载的 Mysql 已自带 Boost)；
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
-DWITH_SYSTEMD=1 \
-DSYSTEMD_PID_DIR=/server/run/mysql \
-DWITH_SSL=system

cmake --build .
cmake --install .
```

::: details 具体加哪些参数呢？请往下看：

1.  使用 SysV 方式启动，cmake 命令如下

    ```bash
    # 对上层目录，其实就是mysql源码进行cmake，用于生成Makefile文件
    cmake -DWITH_BOOST=../boost/boost_1_77_0/ -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ ..
    ```

2.  使用 systemd 方式启动(`-DWITH_SYSTEMD=1`)，cmake 命令如下:

    ```bash
    # 生成systemd文件(即用于放到`/etc/systemd/systemd`中的文件)，否则默认是用SysV方式启动的，文件会放
    # 在/etc/init.d/中，当然SysV方式也是可以用systemctl来调用的，只不过它会自动调用/etc/init.d/中的文件
    # 如果在docker中，就不能用systemd的方式了，因为docker中没有systemd
    cmake -DWITH_BOOST=../boost/boost_1_77_0/ -DWITH_SYSTEMD=1 -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ ..
    ```

3.  使用官方的 cmake 选项(`-DBUILD_CONFIG=mysql_release`)，命令如下：

    ```bash
    cmake -DWITH_BOOST=../boost/boost_1_77_0/ -DBUILD_CONFIG=mysql_release -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/ ..
    ```

:::

### 数据初始化

```bash
# root 有密码，并且标记为过期，非系统 root 用户登录，必须创建一个新密码
mysqld --defaults-file=/etc/mysql/my.cnf --initialize --user=mysql
# root 没有密码，如果要开启可插拔认证，选择没有密码
mysqld --defaults-file=/etc/mysql/my.cnf --initialize-insecure --user=mysql
```
