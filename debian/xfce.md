---
title: Xfce桌面
titleTemplate: Debian 教程
---

# {{ $frontmatter.title }}

## 桌面软件安装

通常 Xfce、Gnome 桌面的软件安装方式是一致的

1. nodejs
2. vscode
3. phpStorm
4. FileZilla
5. WPS
6. Motrix
7. Navicat
8. Apifox
9. flameshot
10. kchmviewer
11. tabby
12. VMware
13. xmind
14. you-get
15. obs-studio
16. screenkey
17. glogg
18. 百度网盘

## 修改 Home 下的目录为英文

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
