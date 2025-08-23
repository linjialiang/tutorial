# zsh 终端

推荐使用 zsh 终端替代 bash

::: code-group

```bash [安装]
apt install zsh -y
```

```bash [切换终端]
# 切换到 zsh
zsh
# 切换到 bash
bash
```

```bash [zsh设为默认终端]
usermod -s /bin/zsh www
usermod -s /bin/zsh root
```

:::

## 安装 ohmyzsh

下面我们使用 ohmyzsh 美化 zsh 界面以及增强 zsh 功能

::: code-group

```bash [curl 方式]
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```bash [wget 方式]
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

```bash [代理安装方式]
proxychains wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod +x install.sh
proxychains ./install.sh
```

:::

## ohmyzsh 插件

oh-my-zsh 默认只开启了内置的 git 插件

::: code-group

```bash [开启内置插件]
# ~/.zshrc
# z实现目录间快速跳转
plugins=(git z)
```

```bash [安装外部插件]
apt install zsh-syntax-highlighting zsh-autosuggestions -y
```

```bash [开启外部插件]
# ~/.zshrc
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

:::

## 自定义主题样式

自定义的样式更加简洁

```bash
# ~/.zshrc

# 注释掉
# ZSH_THEME="robbyrussell"

# 增加代码
PROMPT="%(?:%{$fg_bold[green]%}%n@%m ➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
```

::: tip 修改主机名
上述我们对 zshrc 增加了 `%m` 主机名显示，这主要是为了解决 linux 桌面下登陆其它服务器时更容易区分是本机还是服务器

通过 `hostnamectl` 指令可以手动修改主机名

```bash
# 修改主机名，需要重启才能生效
hostnamectl set-hostname <更短的主机名>
```

:::

## 通配符不支持问题

zsh 默认不支持通配符，需要增加一条语句

```bash
# ~/.zshrc
setopt no_nomatch
```

## 字体支持

`oh-my-zsh` 的主题有一些特殊的图标，需要安装特殊字体支持，这里推荐安装 [Nerd Fonts](https://www.nerdfonts.com/) 系列的 [MesloLGM NF](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip) 字体

::: tip
如果宿主机通过 xshell 远程链接的话，只需要在宿主机上安装 `MesloLGM NF` 字体，并在 xshell 上选择使用 `MesloLGM NF` 字体即可

如果你是安装在本地电脑上，则需要 GUI 支持（即必须安装桌面），然后对使用的终端软件，设置字体即可，配置上类似于 [oh-my-posh]
:::

::: details 完整案例
<<<@/assets/debian/config/zshrc.bash
:::

## 问题修复

::: details 1. oh-my-zsh 自动补全，tab 时，前面会多两个字符，并且无法删除

因为 `~/.profile` 里将语音设为最简单的 `C` 导致的

```bash
# 修改 ~/.profile 文件

# 方式一：将结尾的两行注释掉，并使用 dpkg-reconfigure locales 将默认LANG设为 zh_CN.UTF-8
# LANG=C
# LANGUAGE=C

# 方式二：将结尾的 LANGUAGE 注释掉，将 LANG 设为 zh_CN.UTF-8
LANG=zh_CN.UTF-8
# LANGUAGE=C
```

```bash
# 重启或使用如下语法
source ~/.profile
source ~/.zshrc
```

:::
