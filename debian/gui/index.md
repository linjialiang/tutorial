---
title: Debian GUI
titleTemplate: Debian GUI 教程
---

# {{ $frontmatter.title }}

这里的内容基本上都是在 Xfce 和 Gnome 桌面上测试的，如果使用其他桌面可能会遇到问题，需要自行解决

## 家目录的子目录改成英文

::: code-group

```bash [修改目录映射]
# 修改目录映射文件名
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

```bash [修改目录名]
# 将 Home 目录下的中文目录名改为对应英文
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

:::

## 手工安装字体{#install_fonts}

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

### 无需配置软件

::: code-group

```bash [终端管理]
apt install ./tabby-1.0.197-linux-x64.deb
```

```bash [FTP传输]
apt install filezilla
```

```bash [chm工具]
apt install kchmviewer
```

```bash [下载工具]
apt install ./Motrix_1.8.19_amd64.deb
```

```bash [API开发]
apt install ./apifox_2.3.5_amd64.deb
```

```bash [QQ]
apt install ./linuxqq_3.1.2-13107_amd64.deb
```

```bash [腾讯会议]
apt install ./TencentMeeting_0300000000_3.15.0.402_x86_64_default.publish.deb
```

```bash [录制工具]
apt install obs-studio
```

:::

### WPS

```bash
dpkg -i ./wps-office_11.1.0.11664_amd64.deb
```

::: details 安装字体

wps 需要额外安装两组字体，安装方式见 [[手工安装字体]](#install_fonts)

- WEBDINGS.ttf
- wps_symbol_fonts.zip

:::

::: danger 警告
WPS 请使用 dpkg 安装，否则会卡在中途无法退出，退出后 apt 会被锁住

apt 锁住，通常需要自行根据命令行提示进行解锁
:::

### flameshot

linux 下流行的截图工具

```bash
apt install flameshot
```

快捷键设置成 `F1`

::: details gnome 设置快捷键
![截图全局快捷键](/assets/debian/gui/001.png)
:::

::: details xfce 设置快捷键
`设置` > `键盘`
![截图全局快捷键](/assets/debian/gui/002.png)
:::

::: details 内部快捷键设置
![截图全局快捷键](/assets/debian/gui/003.png)
:::

### xmind

安装 XMind-2020-for-Linux

::: code-group

```bash [安装]
wget https://dl2.xmind.cn/XMind-2020-for-Linux-amd-64bit-10.3.1-202101132117.deb
chmod +x ./XMind-2020-for-Linux-amd-64bit-10.3.1-202101132117.deb
apt install ./XMind-2020-for-Linux-amd-64bit-10.3.1-202101132117.deb
```

```bash [破解]
# 解压 `XMind_2020_10.3.1_Linux_patch.tar.xz` 后
# 将 [app.asar] 文件覆盖到 [/opt/XMind/resources/app.asar]
mv /opt/XMind/resources/app.asar{,.bak}
mv app.asar /opt/XMind/resources/
```

```bash [大客户授权]
# 开启大客户授权所有功能
vim ~/.profile
# 在最后加上以下两行参数：
export VANA_LICENSE_MODE=true
export VANA_LICENSE_TO="emad"
```

:::

### VMware

见 [VMware 独立章节](./vmware)

### PhpStorm

见 [PhpStorm 独立章节](./phpstorm)

### VSCode

见 [VSCode 独立章节](./vscode)

### Sublime Text

见 [Sublime Text 独立章节](./sublime)

### 输入法

见 [输入法独立章节](./pinyin)

### Navicat

见 [Navicat 独立章节](./navicat)
