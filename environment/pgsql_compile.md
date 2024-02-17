---
title: 编译安装 pgsql
titleTemplate: 环境搭建教程
---

# 编译安装 pgsql

学习 PostgreSQL 从编译安装开始，从官网下载制定版本的[[源码包]](https://www.postgresql.org/ftp/source/)

## 编译前准备

下面是 `Debian 12.x` 发行版编译 PostgreSQL 16.1 需要的依赖项。

::: tip 必要说明
PostgreSql 官方推荐使用 GCC 最新版编译器来构建，但为了支持 JIT 这里用的是 `llvm+clang` 编译器套件；

GCC 编辑器不支持 JIT 即时编译功能，即时编译需要增加 `--with-llvm` 选项，需要使用 `llvm+clang` 编译器组合。

C 语言编译器主要有四种： `MSVC`/`GCC`/`MinGW`/`Clang+LLVM`
:::

```bash
apt install -y make pkg-config clang llvm-dev zlib1g-dev liblz4-dev libzstd-dev libreadline-dev libssl-dev libossp-uuid-dev libpam0g-dev libsystemd-dev libxslt1-dev
```

::: details 依赖包说明

| package          | note                                                               |
| ---------------- | ------------------------------------------------------------------ |
| make             | 常用的构建工具，用于自动化编译和链接程序                           |
| pkg-config       | 管理库文件的工具，它提供了一种在编译和链接时自动添加库文件的方法   |
| zlib1g-dev       | 用于 zlib 压缩和解压缩数据的开发库                                 |
| liblz4-dev       | 用于 LZ4 压缩算法的开发库                                          |
| libzstd-dev      | 用于 Zstandard 压缩算法的开发库                                    |
| libreadline-dev  | 提供命令行编辑功能的开发库                                         |
| libssl-dev       | 用于 OpenSSL 支持的开发库                                          |
| libossp-uuid-dev | 基于 OSSP uuid 库的开发库                                          |
| libsystemd-dev   | 用于开发与 systemd 相关的应用程序的包，它提供了一组头文件和库文件  |
| libpam0g-dev     | 用于 PAM 支持的开发库                                              |
| clang            | c/c++ 编译器，`llvm+clang` 是套组合                                |
| llvm             | 用于 LLVM 支持的基本软件包(安装 clang 时自动安装)                  |
| llvm-dev         | 包含了 LLVM 项目的所有源代码文件，以及一些用于构建和测试的工具和库 |
| gcc              | c/c++ 编译器套件(这里使用 llvm+clang，这个没啥用了)                |
| libicu-dev       | 包含了一些用于开发和调试 ICU 应用程序的工具(安装 clang 时自动安装) |
| libxml2-dev      | 包含用于开发 XML 应用程序的库和头文件 (安装 clang 时自动安装)      |
| libxslt1-dev     | 包含用于开发 XSLT 应用程序的库和头文件                             |

:::

::: details 编译选项说明

| commom                | note                                               |
| --------------------- | -------------------------------------------------- |
| --prefix=PREFIX       | 指定安装路径                                       |
| --datadir=DIR         | 指定数据目录路径                                   |
| --enable-debug        | 启用调试模式                                       |
| --with-CC=CMD         | 指定 C 编译器( gcc/clang 注意是区分大小写的)       |
| --with-llvm           | 启用基于 LLVM 的 JIT 支持，优化适合 `OLTP/OLAP`    |
| --with-pgport=PortNum | 指定 pgsql 服务器监听的端口号                      |
| --with-pam            | 允许 pgsql 使用系统的 PAM 认证机制进行用户身份验证 |
| --with-systemd        | 确保 PostgreSQL 与 systemd 服务和日志系统集成      |
| --with-ossp-uuid      | 启用 OSSP UUID 库的支持，用于生成唯一标识符        |
| --with-libxml         | 支持 XML 数据类型                                  |
| --with-libxslt        | 支持 XSLT 转换，扩展 XML 处理能力                  |
| --with-lz4            | 启用 LZ4 压缩算法的支持                            |
| --with-zstd           | 启用 Zstandard 压缩算法的支持                      |
| --with-openssl        | 启用 OpenSSL 支持，用于加密通信                    |

- `--enable-debug`：启用后，可以在调试器中运行程序来分析问题，这会大大增加已安装的可执行文件的大小，并且在非 GCC 编译器上它通常也会禁用编译器优化，生产环境中只建议在选择 GCC 编译器时添加此选项。
- 编译器：`llvm+clang` 跟 `gcc` 是两个编译器，是互斥的，如果要启用 `--with-llvm` 就要使用 `clang`
- 安装部分依赖包时，可能会自动安装 `gcc` 编译器包

:::

## 编译

::: code-group

```bash [系统配置]
# 修改操作系统打开最大文件句柄数
# /etc/security/limits.conf 结尾添加下面两行
# 进行这一步操作的目的是防止linux操作系统内打开文件句柄数量的限制，避免不必要的故障
postgres soft   nofile         65535
postgres hard   nofile        65535
```

```bash [用户及权限]
groupadd postgres
useradd -g postgres -s /sbin/nologin -m postgres
passwd postgres
cp -r /root/{.oh-my-zsh,.zshrc} /home/postgres
chown postgres:postgres /home/postgres/{.oh-my-zsh,.zshrc}

mkdir -p /server/{postgres,pgData}
chmod 750 /server/{postgres,pgData}
chown postgres:postgres /server/{postgres,pgData}

su - postgres -s /bin/zsh
wget https://ftp.postgresql.org/pub/source/v16.1/postgresql-16.1.tar.bz2
tar -xjf postgresql-16.1.tar.bz2 -C ~/
chown postgres:postgres -R ~/postgresql-16.1
mkdir ~/postgresql-16.1/build_postgres
```

```bash [编译指令]
# 使用postgres账户编译
# 关于生产环境要不要添加 --enable-debug 选项问题：使用gcc编译器时可以启用debug
# 使用 llvm+clang 编译器套件时不应该启用debug，因为llvm可以优化pgsql性能，而使用 --enable-debug 选项，通常会禁用编译器的性能优化
su - postgres -s /bin/zsh
cd ~/postgresql-16.1/build_postgres
../configure --prefix=/server/postgres \
--enable-debug \
--with-CC=clang \
--with-llvm \
--with-pam \
--with-systemd \
--with-ossp-uuid \
--with-lz4 \
--with-zstd \
--with-openssl \
--with-libxml \
--with-libxslt
```

```bash [安装指令]
# 使用postgres账户安装
make -j2
make check
make install
# 编译安装完后记得移除源码包，节省空间
rm -rf ~/postgresql-16.1 ~/postgresql-16.1.tar.bz2
```

```bash [数据初始化]
su - postgres -s /bin/zsh
# 初始化 pgsql 数据库，-D 参数指定数据目录路径，
# 执行命令后将在指定目录下创建必要的文件和目录结构
/server/postgres/bin/initdb -D /server/pgData -E UTF8 --locale=zh_CN.utf8 -U postgres
```

```bash [测试]
# 这些指令通常不需要使用
# 启动 pgsql 数据库服务器，-D 参数指定数据目录路径，-l 参数指定了日志文件的路径，
# 执行命令后数据库服务器将开始运行，并记录日志到指定的文件中。
/server/postgres/bin/pg_ctl -D /server/pgData  -l logFile start
# 这个命令用于创建一个名为 "test" 的新数据库。
# 执行该命令后，将在数据库中创建一个名为 "test" 的新数据库。
/server/postgres/bin/createdb test
# 这个命令用于启动 PostgreSQL 命令行客户端，并连接到名为 "test" 的数据库。
# 执行该命令后，你将进入一个交互式的 PostgreSQL 命令行界面，可以执行 SQL 查询和操作。
/server/postgres/bin/psql test
```

:::

## systemd 单元

::: code-group

<<<@/assets/environment/source/service/postgres.service{bash} [unit]

```bash [开机启动]
systemctl enable postgres
systemctl daemon-reload
```

:::

::: tip 注意
使用 `Type=notify` 需要在编译构建阶段 configure 时，使用 `--with-systemd` 选项
:::

## 配置文件

PostgreSQL 主要有以下几个配置文件：

1. `postgresql.conf`：这是主要的配置文件，用于设置数据库的各种参数和选项。它包含了许多可配置的参数，例如内存分配、连接数限制、日志记录等。通过编辑该文件，可以自定义数据库的行为。
2. `postgresql.auto.conf`： 该文件自动生成的，每当 postgresql.conf 被读取时，这个文件会被自动读取。 postgresql.auto.conf 中的设置会覆盖 postgresql.conf 中的设置。
3. `pg_hba.conf`：这个文件用于配置数据库的身份验证方式。它定义了不同类型连接（如本地连接、TCP/IP 连接）的认证方法。你可以根据需要设置不同的认证方式，例如信任所有用户、使用密码加密等。
4. `pg_ident.conf`：这个文件用于配置数据库的用户映射。它允许将外部系统（如操作系统用户）映射到数据库用户。通过配置该文件，可以实现对外部系统的用户进行身份验证和授权。

### 1. 基本配置

```bash [基本]
# /server/pgData/postgresql.conf

external_pid_file = '/server/run/postgres/postgres.pid'
listen_addresses = '127.0.0.1,192.168.66.254'
port = 5432
unix_socket_directories = '/server/run/postgres'
```

### 2. 日志配置

::: code-group

```bash [日志基本]
# /server/pgData/postgresql.conf

# 包括错误日志，访问日志等各种日志
log_destination = 'jsonlog'
logging_collector = on
log_directory = '/server/logs/postgres'
log_file_mode = 0600
```

```bash [方案一]
# /server/pgData/postgresql.conf

# 方案一：日志保留指定天数(推荐)
log_truncate_on_rotation = on       # on 轮换日志文件时，如文件存在，则覆盖内容
log_filename = 'postgresql-%d.log'  # %a保留一周、%d保留[01,31]
log_rotation_age = 1d               # 每天轮换日志文件
log_rotation_size = 0               # 日志文件大小不限制
```

```bash [方案二]
# /server/pgData/postgresql.conf

# 方案二：日志按天来
log_truncate_on_rotation = off      # off 轮换日志文件时，如文件存在，则追加内容
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_rotation_age = 1d
log_rotation_size = 0
```

```bash [方案三]
# /server/pgData/postgresql.conf

# 方案二：日志按大小来
log_truncate_on_rotation = off
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_rotation_age = 0
log_rotation_size = 10M
```

:::

## 权限

```bash
chown postgres:postgres -R /server/postgres /server/pgData /server/logs/postgres /server/run/postgres /server/etc/postgres
find /server/postgres /server/logs/postgres /server/run/postgres /server/etc/postgres -type f -exec chmod 640 {} \;
find /server/postgres /server/logs/postgres /server/run/postgres /server/etc/postgres -type d -exec chmod 750 {} \;
find /server/pgData -type f -exec chmod 600 {} \;
find /server/pgData -type d -exec chmod 700 {} \;
chmod 750 -R /server/postgres/bin
```
