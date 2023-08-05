---
title: 编译安装 MySQL
titleTemplate: 环境搭建教程
---

# {{ $frontmatter.title }}

由于 MySQL 没有 Debian12 的源，所以这里只能选择编译安装

## 下载源码包

![Mysql 源码包](/assets/environment/images/01.png)

上图需要下载第二个，即包含“Includes Boost Headers”的那个，Boost 是一个 C++标准库，因为 mysql 主要是用 C++写的，它依赖于 C++标准库(即 Boost)，如果你下载第一个，那么你还要自己去下载 Boost，而且你自己下载的版本还未必对的上你此时需要编译的 mysql 的版本，所以我们直接下载带 boost 库的，这样 mysql 官方已经给你匹配好了版本。

## 编译前依赖准备

1、cmake 3.75 或更高的版本；
2、gcc 7.1 或更高版本
3、g++
4、openssl 1.0.1 或更高版本；
5、Boost(一个 C++标准库，我们下载的 Mysql 已经是带 Boost 的了)；
6、ncurses 库
7、充足的内存（最好有 2GB 以上的空闲内存，不够的话就添加虚拟内存）；
8、perl(不做 test 就不需要)。

```bash
apt update && apt install -y gcc g++ cmake pkg-config libssl3 libssl-dev libncurses5-dev libncursesw5-dev libaio-dev dpkg-dev libsasl2-dev libudev-dev libbison-dev libldap-dev
```

## 编译

```bash
cd /package
tar -xzf mysql-boost-8.0.34.tar.gz
cd mysql-boost-8.0.34
ls -l
```

发现没有`configure`文件，但是有一个“CMakeLists.txt”文件，说明 mysql 是需要用 cmake 来编译的。

```bash
mkdir /server/mysqld
mkdir build
cd build
# 这里使用 systemd 方式，采用最简选项编译，具体配置由 my.cnf 实现
cmake -DWITH_BOOST=../boost/boost_1_77_0/ -DWITH_SYSTEMD=1 -DCMAKE_INSTALL_PREFIX=/server/mysqld ..
# mysql 编译时间很长，最好用单核处理，这样不影响其它工作正常进行
make
make install
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

## 创建用户

```bash
useradd -c 'This is the MySQL service user' -u 2005 -s /usr/sbin/nologin mysql
chown mysql:mysql /server/data
chown mysql:mysql /server/run/mysqld
chown mysql:mysql /server/logs/mysqld
```

### 数据初始化

```bash
# root 有密码，并且标记为过期，非系统 root 用户登录，必须创建一个新密码
mysqld --defaults-file=/etc/mysql/my.cnf --initialize --user=mysql
# root 没有密码，如果要开启可插拔认证，选择没有密码
mysqld --defaults-file=/etc/mysql/my.cnf --initialize-insecure --user=mysql
```
