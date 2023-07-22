---
title: Debian GUI
titleTemplate: Debian GUI 教程
---

# {{ $frontmatter.title }}

这里的内容基本上都是在 Xfce 和 Gnome 桌面上测试的，如果使用其他桌面可能会遇到问题，需要自行解决

## 家目录的子目录改成英文

1. 修改目录映射文件名

```bash
vim ~/.config/user-dirs.dirs

XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Download"
XDG_TEMPLATES_DIR="$HOME/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Music"
XDG_PICTURES_DIR="$HOME/Pictures"
XDG_VIDEOS_DIR="$HOME/Videos"
```

2. 将 Home 目录下的中文目录名改为对应英文

```bash
cd ~
mv 公共 Public
mv 模板 Templates
mv 视频 Videos
mv 图片 Pictures
mv 文档 Documents
mv 下载 Download
mv 音乐 Music
mv 桌面 Desktop
```

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

## 常用桌面软件安装

### kchmviewer

安装 chm 查看工具

```bash
apt install kchmviewer
```

### flameshot

linux 下流行的截图工具

```bash
apt install flameshot
```

::: details 设置快捷键

:::
