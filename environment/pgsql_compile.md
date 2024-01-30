---
title: 编译安装 pgsql
titleTemplate: 环境搭建教程
---

# 编译安装 pgsql

学习 PostgreSQL 从编译安装开始，从官网下载制定版本的[[源码包]](https://www.postgresql.org/ftp/source/)

## 编译前依赖准备

下面是 `Debian 12.x` 发行版编译 PostgreSQL 16.1 需要的依赖项

```bash
apt install -y build-essential libpam0g-dev libssl-dev uuid-dev zlib1g-dev llvm systemd libreadline-dev icu-devtools
```

| package         | note                                                 |
| --------------- | ---------------------------------------------------- |
| build-essential | 包含 GNU 编译器集合（GCC）和其他编译工具的基本软件包 |
| libpam0g-dev    | 用于 PAM 支持的开发库                                |
| libssl-dev      | 用于 OpenSSL 支持的开发库                            |
| uuid-dev        | 用于 OSSP UUID 库的开发库                            |
| zlib1g-dev      | 用于 LZ4 和 Zstandard 压缩算法的开发库               |
| llvm            | 用于 LLVM 支持的基本软件包                           |
| systemd         | 用于 systemd 支持的基本软件包                        |
| libreadline-dev | 提供命令行编辑功能的开发库                           |
| icu-devtools    | 用于国际化支持的开发工具                             |

## 编译

::: code-group

```bash [用户及权限]
adduser postgres
mkdir -p /server/pgsql /server/data/pgsql
chown postgres /server/data/pgsql
```

```bash [进入构建目录]
cd /package/
mkdir /package/postgresql-16.1/build_pgsql
cd /package/postgresql-16.1/build_pgsql
```

```bash [编译指令]
../configure --prefix=/server/pgsql \
--datadir=/server/data/pgsql \
--enable-debug \
--with-pgport=5432 \
--with-CC=gcc \
--with-llvm \
--with-pam \
--with-systemd \
--with-ossp-uuid \
--with-lz4 \
--with-zstd \
--with-openssl
```

```bash [数据初始化]
su - postgres
# 初始化 pgsql 数据库，-D 参数指定数据目录路径，
# 执行命令后将在指定目录下创建必要的文件和目录结构
/server/pgsql/bin/initdb -D /server/data/pgsql
```

```bash [测试]
# 启动 pgsql 数据库服务器，-D 参数指定数据目录路径，-l 参数指定了日志文件的路径，
# 执行命令后数据库服务器将开始运行，并记录日志到指定的文件中。
/server/pgsql/bin/pg_ctl -D /server/data/pgsql -l logfile start
# 这个命令用于创建一个名为 "test" 的新数据库。
# 执行该命令后，将在数据库中创建一个名为 "test" 的新数据库。
/server/pgsql/bin/createdb test
# 这个命令用于启动 PostgreSQL 命令行客户端，并连接到名为 "test" 的数据库。
# 执行该命令后，你将进入一个交互式的 PostgreSQL 命令行界面，可以执行 SQL 查询和操作。
/server/pgsql/bin/psql test
```

:::

::: details 选项说明

| commom                | note                                        |
| --------------------- | ------------------------------------------- |
| --prefix=PREFIX       | 指定安装路径                                |
| --datadir=DIR         | 指定数据目录路径                            |
| --enable-debug        | 启用调试模式                                |
| --with-pgport=PORTNUM | 指定 pgsql 服务器监听的端口号               |
| --with-CC=CMD         | 指定 C 编译器                               |
| --with-llvm           | 启用 LLVM 支持，允许使用 LLVM 进行优化      |
| --with-pam            | 启用 PAM 支持，用于身份验证                 |
| --with-systemd        | 启用 systemd 支持，用于管理 pgsql 服务      |
| --with-ossp-uuid      | 启用 OSSP UUID 库的支持，用于生成唯一标识符 |
| --with-lz4            | zlib 启用 LZ4 压缩算法的支持                |
| --with-zstd           | zlib 启用 Zstandard 压缩算法的支持          |
| --with-openssl        | 启用 OpenSSL 支持，用于加密通信             |

:::
