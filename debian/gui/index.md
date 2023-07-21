---
title: Debian GUI
titleTemplate: Debian GUI 教程
---

# {{ $frontmatter.title }}

这里的内容基本上都是在 Xfce 和 Gnome 桌面上测试的，如果使用其他桌面可能会遇到问题，需要自行解决

## 手工安装字体

linux 通过指令，可以快速安装需要的字体

::: code-group

```bash [安装包]
# 1. 安装字体索引包
apt install fontconfig xfonts-utils
```

```bash [创建目录]
# 2. /usr/share/fonts 下创建独立目录
mkdir /usr/share/fonts/my-fonts
chmod 755 /usr/share/fonts/my-fonts
```

```txt [解压]
3. 将字体解压到 my-fonts 目录（支持子目录）
```

```bash [建立索引]
# 4. 建立字体索引信息更新字体缓存
cd /usr/share/fonts/my-fonts
mkfontscale && mkfontdir && fc-cache -fv
```

```bash [验证字体]
# 5. 最后验证字体是否安装成功
fc-list|grep 'my-fonts'
```

:::
