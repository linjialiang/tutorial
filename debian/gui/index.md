---
title: Debian GUI
titleTemplate: Debian GUI 教程
---

# {{ $frontmatter.title }}

这里的内容基本上都是在 Xfce 和 Gnome 桌面上测试的，如果使用其他桌面可能会遇到问题，需要自行解决

## 手工安装字体

linux 通过指令，可以快速安装需要的字体

1. 安装字体索引包

   ```bash
   apt install fontconfig xfonts-utils
   ```

2. /usr/share/fonts 下创建独立目录

   ```bash
   mkdir /usr/share/fonts/my-fonts
   chmod 755 /usr/share/fonts/my-fonts
   ```

3, 将字体解压到 my-fonts 目录（支持子目录）

4. 建立字体索引信息更新字体缓存

   ```bash
   cd /usr/share/fonts/my-fonts
   mkfontscale && mkfontdir && fc-cache -fv
   ```
