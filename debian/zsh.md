# zsh 终端

开发环境推荐使用 zsh 终端替代 bash

## 安装 zsh

```bash
apt install zsh -y
```

## 终端切换

### 1. bash 切换到 zsh

```bash
zsh
```

### 2. zsh 切换到 bash

```bash
bash
```

## 默认启用 zsh

这里推荐单独为用户指定 zsh 为默认终端

1. 查看 shell 列表

```bash
cat /etc/shells
/bin/sh
/bin/bash
/usr/bin/bash
/bin/rbash
/usr/bin/rbash
/bin/dash
/usr/bin/dash
/bin/zsh
/usr/bin/zsh
```

```bash
usermod -s /bin/zsh www
usermod -s /bin/zsh root
```

下面我们可以使用 ohmyzsh 美化 zsh 界面以及增强 zsh 功能

## 安装 ohmyzsh

### 1. 官方安装

::: details curl 方式

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

:::

::: details wget 方式

```bash
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

:::

::: tip
国内 github 经常被墙，这种方式不是很妥当，这里只是简单说明，具体请移步到 [ohmyzsh 官网](https://ohmyz.sh/)
:::

### 2. 魔改安装

国内可能无法下载上述安装脚本，可以选择手动安装（该仓库属于私有）

::: details curl 方式

```bash
bash -c "$(curl -fsSL https://gitee.com/linjialiang/ohmyzsh/raw/main/tools/install.sh)"
```

:::

::: details wget 方式

```bash
bash -c "$(wget https://gitee.com/linjialiang/ohmyzsh/raw/main/tools/install.sh -O -)"
```

:::

事实上官方的安装脚本其本质是：

1. 将 zsh 的 github 仓库拉取到用户根目录的 `ohmyzsh` 下，
2. 执行 `~/ohmyzsh/tools/install.sh` 进行安装操作

> 具体操作：

1. 拷贝官方仓库

    拉取 ohmyzsh 官方仓库，修改 `tools/install.sh` 文件中的仓库信息，提交到自己的国内仓库

    ::: details 拉取官方仓库

    ```bash
    cd ~
    git clone https://gitee.com/linjialiang/ohmyzsh.git ohmyzsh
    cd ohmyzsh
    ```

    :::

    ::: details 修改后的 install.sh
    <<<@/assets/debian/zsh/install.bash
    :::

    ::: tip
    通常你不需要频繁去更新你私有的 ohmyzsh，因为终端并不是 web 开发者的主战场
    :::

2. 拷贝安装脚本

    将我们改过的 `install.sh` 文件拷贝到用户根目录，修改所属用户以及执行权限后执行安装

    ::: details root 用户

    ```bash
    cd ~
    chmod +x install.sh
    bash install.sh
    ```

    :::

    ::: details www 用户

    ```bash
    cd ~
    chmod +x install.sh
    bash install.sh
    ```

    :::

::: tip
远程安装 ohmyzsh 前，请务必开启一个全新的终端，并确保 install.sh 文件所属用户为当前登录用户
:::

## ohmyzsh 插件

oh-my-zsh 默认只开启了内置的 git 插件

推荐开启内置插件：`z`(插件目录间快速跳转)

```bash
# 增加z插件
plugins=(git z)
```

### 1. 安装外部插件

使用 apt 安装 oh-my-zsh 全局插件，这样多个用户就只需要安装一次

```bash
apt install zsh-syntax-highlighting zsh-autosuggestions -y
```

### 2. 绑定插件

在不同用户 `~/.zshrc` 配置文件中，增加如下内容，重启后即可绑定插件

```bash
vim ~/.zshrc
```

::: tip 正确引入

```bash
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

:::

::: warning 错误引入

网上很多都是要在 plugins 参数里加入插件名称，但是使用 apt 安装的全局插件，这种引入方式是无法正常调用插件的

```bash
# 全局的外部插件，错误的引入方式
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
```

以上这种方式仅针对将源码安装在 `~/.oh-my-zsh/custom/plugins/` 目录下插件才能生效

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

-   agnoster : `~/.oh-my-zsh/themes/agnoster.zsh-theme`

-   zsh 终端配置文件 : `~/.zshrc`

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
