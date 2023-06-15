---
title: 安装 pgsql
titleTemplate: 环境搭建教程
---

# {{ $frontmatter.title }}

## 配置源 {#conf-source}

```bash
apt install gnupg2 -y
echo "deb http://mirrors.ustc.edu.cn/postgresql/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget http://mirrors.ustc.edu.cn/postgresql/repos/apt/ACCC4CF8.asc
apt-key add ACCC4CF8.asc
apt update
apt install postgresql-15 -y
```

::: warning 注意：
Debian 12 官方源收录的版本已经是 `postgresql-15` ，所以不需要重新配置源

```bash
apt update
apt install postgresql -y
```

:::
