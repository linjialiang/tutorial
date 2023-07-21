---
title: 配置操作系统
titleTemplate: Debian 教程
---

# {{ $frontmatter.title }}

不管是云服务器、虚拟终端、还是桌面系统，新安装的 Debian 系统都是比较干净的，为了能符合我们使用，很有必要对系统进行适当的配置

这里选择最简洁方式安装的虚拟机终端为例：

## 镜像源

我们首先要解决的是软件包的下载问题，所以切换到国内镜像是第一步

### 1. 源说明

中科大对 debian 的镜像副本比较全面，主要收录了一下 6 类

| 代号            | 说明                         |
| --------------- | ---------------------------- |
| debian          | Debian 软件源                |
| debian-security | Debian 软件安全更新源        |
| debian-cd       | Debian 镜像源                |
| debiancn        | Debian 中文社区软件源的镜像  |
| deb-multimedia  | Debian 第三方多媒体软件源    |
| debian-cdimage  | debian-cd 外的准官方安装镜像 |

::: info bookworm 软件源

> 这是 Debian 11 的软件源说明：

| bookworm 版本             | 说明                            |
| ------------------------- | ------------------------------- |
| bookworm                  | bookworm 软件源                 |
| bookworm-updates          | bookworm 发布的兼容更新         |
| bookworm-security         | bookworm 发布的安全更新（重要） |
| bookworm-proposed-updates | 下一个小版本发布的更新（可选）  |
| bookworm-backports-sloppy | 向后移植的较新的软件包（草率）  |
| bookworm-backports        | 向后移植的较新的软件包（可选）  |

:::

### 2. 修改镜像源

::: info 更换镜像源地址

```bash
cp /etc/apt/sources.list{,.bak}
vi /etc/apt/sources.list
```

:::

> 镜像列表:

::: details 中科大镜像-完整版:
<<<@/assets/debian/apt/zkd-all.bash
:::

::: details 中科大镜像-服务器版:
<<<@/assets/debian/apt/zkd-server.bash
:::

::: details 腾讯云内网-完整版:
<<<@/assets/debian/apt/tx-all.bash
:::

::: details 腾讯云内网-服务器版:
<<<@/assets/debian/apt/tx-server.bash
:::

::: tip 提示
阿里云、腾讯云等云服务器都会自带内网镜像，我们只要开放对内网 ip 的出入访问权限即可
:::

### 3. 更新软件包

```bash
apt update
apt upgrade
```

### 4. 升级整个系统

```bash
apt update
apt full-upgrade
```

## 连接终端

如果未安装 ssh，需要先安装

```bash
apt install ssh
```

::: info 说明
对于终端，这里推荐使用 ssh 客户端工具连接
:::

### 1. SSH 客户端

Windows 桌面下推荐使用 xshell 客户端

Linux 桌面下自带终端的 SSH 远程体验还行，至于更多工具请阅读 [GUI 篇](./gui/)

### 2. 开放端口

虚拟机：开启桥接模式不需要考虑端口问题，其它模式请先阅读 [虚拟网络章节](./virtual_network)

云服务器：开启对应端口(通常 22)入方向

### 3. 建立链接

连接 SSH 有两种验证方式：

1. `用户名+密码` 验证登录
2. `密钥对` 验证登录(这是被推荐的)，[点击查看](#ssh-密钥登录)

::: details 允许 root 登录

> 为了安全起见，sshd 默认关闭了 root 用户的登录，配置系统时我们需要开启 root 登录：

- 备份 sshd 配置文件并打开：

  ```bash
  cp /etc/ssh/sshd_config{,.bak}
  vi /etc/ssh/sshd_config
  ```

- ssh 允许 Root 用户登录：

  ```bash
  # PermitRootLogin prohibit-password
  PermitRootLogin yes
  ```

:::

::: warning 关于部署环境
部署环境产品上线后，为了安全起见，SSH 应该禁止使用 root 用户登录

如果真有必要，也应该使用密钥对的方式登录，并且密钥对应该设置严谨的 `密钥锁码`
:::

## 配置网络（桥接模式）

虚拟机：作为开发环境，需要设置成固定 IP

服务器：默认配置已经可用，如需更多配置，可以参考虚拟机

桌面：通常动态获取即可

### 1. 查看网卡信息

虚拟机迁移到其它宿主机是，网卡会发生改变，使用下面指令查看：

```bash
ip addr
```

### 2. 网络配置文件

| file                    | info         |
| ----------------------- | ------------ |
| /etc/network/interfaces | 配置 ip 地址 |
| /etc/resolv.conf        | 配置 dns     |

### 3. 配置 ip 地址

```bash
cp /etc/network/interfaces{,.bak}
vi /etc/network/interfaces
```

::: details 静态获取 IP 地址
<<<@/assets/debian/config/interfaces_static.bash
:::

::: details 动态获取 IP 地址
<<<@/assets/debian/config/interfaces_dhcp.bash
:::

::: tip
如果路由器对虚拟机网卡绑定了 IP 地址，也可以动态获取 ip 地址
:::

### 4. 配置 DNS

DNS 通常保持默认即可，如需配置具体操作参考如下：

```bash
cp /etc/resolv.conf{,.bak}
vi /etc/resolv.conf
```

案例如下：

```bash
domain lan
search lan
nameserver 192.168.10.1
```

> 完成以上步骤，重启虚拟主机，网络配置到此完成！

## 网络配置（NAT 模式）

虚拟机 NAT 模式的配置略有不同，下面是基于 vmware 的详细讲解

::: details vmware 设置
![](/assets/debian/nat/1.png)
![](/assets/debian/nat/2.png)
![](/assets/debian/nat/3.png)
:::

::: details 配置 ip 地址
<<<@/assets/debian/nat/interfaces_static.bash
::: tip 注意：网关是 `192.168.6.2` 而不是 `.1`
:::

::: details 配置 DNS

```bash
nameserver 192.168.6.2
```

::: tip 注意：DNS 是 `192.168.6.2` 而不是 `.1`
:::

## 设置中文环境

汉语才是母语，有必要设置成中文环境 `zh_CN.UTF-8`

```bash
# 检查是否安装 locales
apt list --installed locales
# 未安装，则需要先安装
apt install locales

dpkg-reconfigure locales
```

::: tip
部署环境也可以设置为中文环境，这个对服务器性能影响不大
:::

## 设置时区

tzdata 可以设置时区

选项中文： `亚洲 > 上海` 选项英文： `Asia > Shanghai`

```bash
dpkg-reconfigure tzdata
```

::: tip 提示
腾讯云在大陆的服务器安装 Debian 后也是西八区，我们需要自己设置时区
:::

## 常用软件包

```bash
apt install wget curl vim bat htop tar gzip bzip2 xz-utils zip unzip lrzsz git neofetch proxychains4 -y
```

::: details 详情

1. wget -- 传输工具
2. curl -- 传输工具
3. Vim -- vim 编辑器(桌面加上 vim-gtk3)
4. bat -- bat 用于替代 cat，默认指令是 batcat，可以设置别名
5. htop -- 交互式的进程浏览器，用于替代 top 命令
6. tar -- 打包工具
7. gzip -- 压缩工具
8. bzip2 -- 压缩工具
9. xz-utils -- 压缩工具
10. zip -- 压缩工具（composer 会用到）
11. unzip -- 解压工具（composer 会用到）
12. lrzsz -- 传输工具
13. Git -- Git 版本控制管理工具(部署环境不需要安装)
14. proxychains4 -- 代理工具
15. neofetch -- 查看系统信息
16. ntpdate -- 解决时间差 8 小时问题
17. firewalld -- 防火墙工具
18. fzf -- 命令行模糊查询工具

:::

### 配置 Git

::: code-group
<<<@/assets/debian/config/git_configs.bash [全局配置]

```bash [查看配置信息]
git config --list
git config --global --list
```

:::

### Git 仓库密码

linux 安装的 Git 默认没有开启仓库密码记忆功能，这对于开发环境来讲不是很友好，下面是解决办法：

::: code-group

```bash [记住仓库密码]
# 下面指令会在用户目录下生成文件，该文件用于记录 Git 仓库用户名和密码

# 当前登陆用户 - 全局配置
git config --global credential.helper store
# 当前项目配置
git config --local credential.helper store
```

```bash [仓库账户密码变动]
# 如果 Git 仓库用户名和密码有变动，需要使用下面的指令，然后重新输入用户名和密码

# 当前登陆用户 - 全局配置
git config --global --unset credential.helper -f
# 当前项目配置
git config --local --unset credential.helper -f
```

:::

### Git 默认分支

设置默认分支为 main

```bash
# 全局
git config --global init.defaultBranch main
# 当前项目
git config --local init.defaultBranch main
```

### 配置 bat

bat 是 cat 替代品，比 cat 强大很多，配置非常简单

```bash
# 在 `.zshrc` 和 `.bashrc` 配置文件下设置别名：
alias bat='batcat'
```

## 美化终端

::: code-group

```bash [操作 bash]
# 修改 `~/.bashrc` 可以美化当前用户的 bash 终端，具体如下：

cp ~/.bashrc{,.bak}
vim ~/.bashrc
```

<<<@/assets/debian/config/bashrc.bash [bash 案例]

```bash [操作 zsh]
# 修改 `~/.zshrc` 可以美化当前用户的 zsh 终端，具体如下：

cp ~/.zshrc{,bak}
vim ~/.zshrc
```

<<<@/assets/debian/config/zshrc.bash [zsh 案例]

:::

最后使用 `source ~/.bashrc` 或 `source ~/.zshrc` 更新终端界面

::: tip 提示
以上的 zsh 需要安装和配置 zsh-my-zsh 插件，具体请阅读[zsh 终端](./zsh)
:::

## SSH 密钥登录

SSH 默认采用密码登录，这种登录方式很多缺点：

- 简单的密码不安全
- 复杂的密码不容易记忆
- 每次手动输入也很麻烦

SSH 密钥登录是更好的解决方案，这里介绍如何创建和使用秘钥，更多内容请阅读阮一峰的[SSH 教程](https://wangdoc.com/ssh/index.html)

下面以`开发主用户`为例：

### 1. 创建秘钥对

```bash
ssh-keygen -t rsa -b 1024 -C "www@192.168.10.254" -f ~/.ssh/ras
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/www/.ssh/ras
Your public key has been saved in /home/www/.ssh/ras.pub
The key fingerprint is:
SHA256:WMvu8NAp5n755KEt1PkMlQ6bZm64vuHpIupBQ+TT20g www@192.168.10.254
The key's randomart image is:
+---[RSA 1024]----+
|  .              |
| o .             |
|  + E   .    .   |
| . o + + .. o    |
|  o o o S. B     |
| . .   o..O .    |
|  .   =.=*o+     |
|   ..o.B=Bo.o    |
| .o. oo=@*+      |
+----[SHA256]-----+
```

| 指令说明 | common                                               |
| -------- | ---------------------------------------------------- |
| 私钥路径 | `/home/www/.ssh/ras`                                 |
| 公钥路径 | `/home/www/.ssh/ras.pub`                             |
| 加密类型 | `-t rsa`                                             |
| 加密级别 | `-b 1024`                                            |
| 秘钥说明 | `-C "www@192.168.10.254"`                            |
| 秘钥密保 | 这里设为空便于开发环境使用，部署环境推荐增加秘钥密保 |

### 2. 秘钥对权限

生成的密钥对不应该让别人看到，具体权限如下：

```bash
cd /home/www/.ssh
chown www:www ras ras.pub
chmod 600 ras ras.pub
```

### 3. 秘钥对登录原理

::: details 秘钥对登录验证原理：

1. 客户端发送秘钥对中的 `私钥` 给服务器端
2. 服务器使用秘钥对中的 `公钥` 来验证
3. 密钥对验证通过，建立链接

:::

::: details 从中我们可以看出来几个问题：

1. `秘钥` 需要客户端妥善保管，如果 `秘钥` 被黑客获取，黑客就能登录服务器
2. `公钥` 路径需要确保让服务器的 ssh 验证工具识别
   - openssh 默认公钥路径： `~/.ssh/authorized_keys`
3. 其它用户对公钥需要有读取权限，即：644

:::

### 4. 配置公钥

```bash
cp ras.pub ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys
```

### 5. 配置私钥

私钥是直接给客户端保管的，比如：Windows 用户需要导入到 `xshell` 等 SSH 客户端里

::: details xshell 导入秘钥对
![xshell导入秘钥对](/assets/debian/key.png 'xshell导入秘钥对')
:::

::: tip
开发环境在不用考虑安全性的情况下，可以将所有用户的密钥对都设置为同一对，这样更加方便

如果你不会使用 linux 终端生成密钥对，也可以使用 xshell 等工具生成，这也完全可以使用的

像阿里云或者腾讯云都可以在后台管理密钥对，这样可以预防秘钥丢失，并且针对 root 用户提供自动绑定功能
:::
