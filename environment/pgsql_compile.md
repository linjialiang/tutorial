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
| gcc              | c/c++ 编译器套件                                                   |
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
| --with-pgport=PORTNUM | 指定 pgsql 服务器监听的端口号                      |
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
- 安装 clang 的时候会自动安装 gcc，因为安装 clang 包依赖 gcc

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
useradd -g postgres -s /bin/zsh -m postgres
passwd postgres
cp -r /root/{.oh-my-zsh,.zshrc} /home/postgres
chown postgres:postgres /home/postgres/{.oh-my-zsh,.zshrc}

mkdir -p /server/{postgres,pgData}
chmod 750 /server/{postgres,pgData}
chown postgres:postgres /server/{postgres,pgData}

su - postgres
wget https://ftp.postgresql.org/pub/source/v16.1/postgresql-16.1.tar.bz2
tar -xjf postgresql-16.1.tar.bz2 -C ~/
chown postgres:postgres -R ~/postgresql-16.1
mkdir ~/postgresql-16.1/build_postgres
```

```bash [编译指令]
# 使用postgres账户编译
su - postgres
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
```

```bash [数据初始化]
su - postgres
# 初始化 pgsql 数据库，-D 参数指定数据目录路径，
# 执行命令后将在指定目录下创建必要的文件和目录结构
/server/pgsql/bin/initdb -D /server/pgData -E UTF8 --locale=zh_CN.utf8 -U postgres
# 启动 pgsql 数据库服务器，-D 参数指定数据目录路径，-l 参数指定了日志文件的路径，
# 执行命令后数据库服务器将开始运行，并记录日志到指定的文件中。
/server/pgsql/bin/pg_ctl -D /server/pgData  -l logfile start
# 这个命令用于创建一个名为 "test" 的新数据库。
# 执行该命令后，将在数据库中创建一个名为 "test" 的新数据库。
/server/pgsql/bin/createdb test
# 这个命令用于启动 PostgreSQL 命令行客户端，并连接到名为 "test" 的数据库。
# 执行该命令后，你将进入一个交互式的 PostgreSQL 命令行界面，可以执行 SQL 查询和操作。
/server/pgsql/bin/psql test
```

:::
