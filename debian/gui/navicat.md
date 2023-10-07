---
title: Navicat
titleTemplate: Debian 教程
---

# Navicat

Navicat 是 `.appimage` 格式，双击即可使用

## 破解

1. 首先将源码破解后重新打包成 `.appimage` 格式；

2. 配置 `/etc/hosts` 文件；

   ```bash
   127.0.0.1	localhost
   192.168.10.101	lenovo

   # The following lines are desirable for IPv6 capable hosts
   ::1     localhost ip6-localhost ip6-loopback
   ff02::1 ip6-allnodes
   ff02::2 ip6-allrouters

   127.0.0.1	tp.io core.qyadmin.io
   127.0.0.1	php-environment.io
   0.0.0.0		activate.navicat.com // [!code ++]
   ```

3. 将 `navicat-config.tar` 包解压到 `~/.config/` 目录下。

::: tip 提示
双击 `.appimage` 文件启动，完成破解

破解网站 `https://navicat.rainss.cc`
:::

::: details desktop
<<<@/assets/debian/gui/desktop/navicat16-premium.desktop{bash}

::: tip
图标和执行文件放到指定位置
:::
