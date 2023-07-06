---
title: 概述
titleTemplate: 让 laravel 运行起来
---

# {{ $frontmatter.title }}

[laravel 中文社区的 wiki](https://learnku.com/laravel/wikis) 开发环境有很多，这里推荐使用跟线上环境尽量一致的环境

## 安装 laravel

只推荐使用 composer 安装 laravel

::: code-group

```bash [安装]
# 海外服务器或全局代理
composer create-project laravel/laravel laravel
```

```bash [代理安装]
# 使用 proxychains 软件走代理
proxychains composer create-project laravel/laravel laravel
```

```bash [全局配置镜像]
# 腾讯云：
composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer/
# 阿里云：
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
# 华为云：
composer config -g repo.packagist composer https://repo.huaweicloud.com/repository/php/
```

```bash [取消配置]
# 这会恢复成默认的
composer config -g --unset repos.packagist
```

:::

::: tip 关于国内 composer 镜像源
对于 laravel 来说国内 composer 源没有一个能打的。有条件的伙伴，走代理使用 composer 官方源安装是最好的选择。
:::
