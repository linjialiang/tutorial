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
如果安装版本 14 有中文手册，15 暂时还没有中文手册 `[2023-08-02]`

postgresql-14 的 [中文手册](http://www.postgres.cn/docs/14/index.html) 基本已经翻译完成，所以我选择这个版本来入门 pgsql
:::
