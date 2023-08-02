---
title: 安装 pgsql
titleTemplate: 环境搭建教程
---

# {{ $frontmatter.title }}

## 配置源 {#conf-source}

官方推荐使用源安装，这是非常好的。

只有等你对操作系统和 pgsql 有足够深的了解，再考虑自己编译吧！

```bash
apt install gnupg2 -y
echo "deb http://mirrors.ustc.edu.cn/postgresql/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget -qO- http://mirrors.ustc.edu.cn/postgresql/repos/apt/ACCC4CF8.asc | tee /etc/apt/trusted.gpg.d/postgresql.asc
apt update
apt install postgresql-15 -y
```

::: tip 关于版本选择
v14 有 [[中文文档]](http://www.postgres.cn/docs/14/index.html)

v15 还没有中文手册 `[2023-08-02]`
:::

## 配置文件

::: code-group

```bash [操作]
cp /etc/postgresql/15/main/postgresql.conf{,.bak}
vim /etc/postgresql/15/main/postgresql.conf
```

<<<@/assets/environment/source/pgsql/postgresql.conf{ini} [新配置]
<<<@/assets/environment/source/pgsql/postgresql.conf.bak{ini} [原始配置]

:::

## 权限

```bash
# 数据目录
chown postgres:postgres /server/pgsql
chmod 700 /server/pgsql

# pid unix_socket
chown postgres:postgres /server/run/pgsql
chmod 775 /server/run/pgsql
```
