---
title: 在 Debian 上安装 Docker 引擎
titleTemplate: Docker 教程
---

# {{ $frontmatter.title }}

Docker 引擎是一种开源容器化技术，用于构建和容器化应用程序。Docker 引擎充当客户端-服务器应用程序，具有：

1. 具有长时间运行的守护进程 dockerd 的服务器。
2. 指定程序可用于与 Docker 守护程序通信和指示 Docker 守护程序的接口的 API。
3. 命令行界面 （CLI） 客户端 docker 。

::: cli
CLI 使用 Docker API 通过脚本或直接 CLI 命令来控制 Docker 守护程序或与之交互。

许多其他 Docker 应用程序使用底层 API 和 CLI。

守护程序创建和管理 Docker 对象，例如映像、容器、网络和卷。
:::

::: tip 先决条件
如果使用 ufw 或 firewalld 来管理防火墙设置，请注意，当您使用 Docker 公开容器端口时，这些端口会绕过防火墙规则。有关更多信息，请参阅 Docker 和 ufw 。
:::

## 操作系统要求

要安装 Docker 引擎，您需要这些 Debian 版本之一的 64 位版本：

- Debian Bookworm 12 (testing)
- Debian Bullseye 11 (stable)
- Debian Buster 10 (oldstable)

Docker Engine for Debian 兼容 x86_64（或 amd64）、armhf 和 arm64 架构。

## 卸载旧版本

在安装 Docker 引擎之前，必须首先确保卸载任何冲突的包。

发行版维护者在其存储库中提供 Docker 软件包的非官方发行版。您必须先卸载这些软件包，然后才能安装 Docker 引擎的正式版本。

要卸载的非官方软件包是：

- docker.io
- docker-compose
- docker-doc
- podman-docker

```bash
apt autoremove docker.io docker-doc docker-compose podman-docker containerd runc --purge
# 主机上的映像、容器、卷或自定义配置文件不会自动删除。要删除所有映像、容器和卷，请执行以下操作：
rm -rf /var/lib/docker
rm -rf /var/lib/containerd
```

## 安装方法

您可以根据需要以不同的方式安装 Docker 引擎：

1. Docker Engine 与 Docker Desktop for Linux 捆绑在一起。这是最简单、最快捷的入门方法。
2. 从 Docker 的 apt 存储库设置并安装 Docker 引擎。
3. 手动安装并手动管理升级。
4. 使用方便的脚本。仅建议用于测试和开发环境。

这里介绍使用 apt 存储库进行安装的方式

## 设置存储库

在新主机上首次安装 Docker 引擎之前，您需要设置 Docker 存储库。之后，您可以从存储库安装和更新 Docker。

1. 更新 apt 包索引并安装包以允许 apt 通过 HTTPS 使用存储库：

   ```bash
   apt update -y
   apt install ca-certificates curl gnupg -y
   ```

2. 添加 Docker 的官方 GPG 密钥：

   ::: code-group

   ```bash [中科大]
   install -m 0755 -d /etc/apt/keyrings
   curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg \
   | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   chmod a+r /etc/apt/keyrings/docker.gpg
   ```

   ```bash [官网]
   install -m 0755 -d /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/debian/gpg \
   | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   chmod a+r /etc/apt/keyrings/docker.gpg
   ```

   :::

3. 使用以下命令设置存储库：

   路径： `/etc/apt/sources.list.d/docker.list`

   ::: code-group

   ```bash [中科大]
   echo \
   "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] \
   http://mirrors.ustc.edu.cn/docker-ce/linux/debian bookworm stable" \
   | tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

   ```bash [官网]
   echo \
   "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] \
   https://download.docker.com/linux/debian bookworm stable" \
   | tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

   :::

## 安装 Docker CE 引擎

Docker 从 17.03 版本之后分为 CE（Community Edition: 社区版） 和 EE（Enterprise Edition: 企业版），通常使用社区版就可以了。

::: code-group

```bash [最近]
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

```bash [指定版本]
# 要安装特定版本的 Docker 引擎，请首先列出存储库中的可用版本：
apt-cache madison docker-ce | awk '{ print $3 }'
5:24.0.2-1~debian.12~bookworm
5:24.0.1-1~debian.12~bookworm
5:24.0.0-1~debian.12~bookworm
<更新...>
# 选择所需的版本并安装：
VERSION_STRING=5:24.0.2-1~debian.12~bookworm
apt install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin
```

:::

## 检测

通过运行 hello-world 映像验证 Docker 引擎安装是否成功：

```bash
docker run hello-world
```

## 从包中安装

镜像的 `poll` 目录可以下载 Docker 相关的各种 `.deb` 包，如：

http://mirrors.ustc.edu.cn/docker-ce/linux/debian/dists/bookworm/pool/stable/amd64/
