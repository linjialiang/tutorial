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
usermod -s /bin/zsh emad
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
./install.sh
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

## 使用主题

### 1. 修改主题

ZSH_THEME 全局变量用于设置主题

```bash
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
```

### 2. 优化主题

zsh 的主题虽然很美观，但是设置上通常都按作者的意愿来的，我们需要稍微调整下。

下面是针对 agnoster 主题的调整（最近喜欢 `robbyrussell` 主题）

> 说明： oh-my-zsh 推荐使用 `robbyrussell`， 而 oh-my-posh 则推荐使用 `agnoster`

### 3. 配置文件路径

- agnoster : `~/.oh-my-zsh/themes/agnoster.zsh-theme`

- zsh 终端配置文件 : `~/.zshrc`

::: tip 两者关系
被修改的是 zsh 终端配置文件，

zsh 终端配置文件参考当前主题配置文件来修改

:::

### 4. 使用 agnoster 主题

::: details 修改主题：

```bash
# ~/.zshrc 修改

# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
```

:::

底部需要添加两处内容，用于覆盖主题配置文件

::: details 去掉主机名：

```bash
# ~/.oh-my-zsh/themes/agnoster.zsh-theme 自带

prompt_context() {
    if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default "%(!.%{%F{yellow}%}.)%n@%m"
    fi
}
```

```bash
# ~/.zshrc 添加用于覆盖主题自带

prompt_context() {
    if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default "%(!.%{%F{yellow}%}.)%n"
    fi
}
```

:::

::: details 去掉全路径：

```bash
# ~/.oh-my-zsh/themes/agnoster.zsh-theme 自带

prompt_dir() {
    prompt_segment blue $CURRENT_FG '%~'
}
```

```bash
# ~/.zshrc 添加用于覆盖主题自带

prompt_dir() {
    prompt_segment blue $CURRENT_FG '%c'
}
```

:::

### 5. 使用 robbyrussell 主题

使用 `robbyrussell` 我们无法实时获取当前用户，这会造成一些麻烦

而 `robbyrussell` 主题的代码非常简单，我们可以直接不使用主题，自定义 zsh 样式：

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

### 6. 字体支持

`oh-my-zsh` 的主题有一些特殊的图标，需要安装特殊字体支持，这里推荐安装 [Nerd Fonts](https://www.nerdfonts.com/) 系列的 [MesloLGM NF](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip) 字体

::: tip
如果宿主机通过 xshell 远程链接的话，只需要在宿主机上安装 `MesloLGM NF` 字体，并在 xshell 上选择使用 `MesloLGM NF` 字体即可

如果你是安装在本地电脑上，则需要 GUI 支持（即必须安装桌面），然后对使用的终端软件，设置字体即可，配置上类似于 [oh-my-posh](../basic-tools/powershell/use#win11-系统)
:::

## 附录

### 1. 解决 zsh 不支持通配符

```bash
vim ~/.zshrc

# zsh配置文件中加入一条语句即可
setopt no_nomatch
```
