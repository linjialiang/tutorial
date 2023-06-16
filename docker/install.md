---
title: 安装 docker
titleTemplate: Docker 教程
---

# {{ $frontmatter.title }}

这里介绍 Debian 手动安装 docker

## 卸载旧版本

Docker 的旧版本被称为 docker，docker.io 或 docker-engine，如果已安装请卸载它们：

```bash
apt autoremove containerd runc docker docker-* docker.io --purge
```

| 包            | 说明                   |
| ------------- | ---------------------- |
| containerd    | 开放可靠的容器守护程序 |
| runc          | linux 命令行工具       |
| docker        | docker 引擎名          |
| docker-engine | docker 引擎名          |
| docker.io     | docker 引擎名          |

::: info Docker 与容器
Docker 在容器的基础上，进行了进一步的封装，从文件系统、网络互联到进程隔离等等，极大的简化了容器的创建和维护。

::: tip 提示
runc 是一个命令行客户端，用于运行根据 `Open Container Initiative (OCI)` 格式打包的应用程序，并且是 `Open Container Initiative` 规范的兼容实现。
containerd 是一个守护程序，它管理容器生命周期，提供了在一个节点上执行容器和管理镜像的最小功能集。
:::

## 安装 Docker CE

Docker 从 17.03 版本之后分为 CE（Community Edition: 社区版） 和 EE（Enterprise Edition: 企业版），通常使用社区版就可以了。

### 安装 apt 依赖包

```bash
apt install gnupg2 software-properties-common -y
```

::: tip 通过 HTTPS 来获取仓库

部署环境使用 https，开发环境使用 http 即可

```bash
apt install apt-transport-https ca-certificates gnupg2 software-properties-common -y
```

:::

::: tip 添加 Docker 的官方 GPG 密钥：

```bash
wget http://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg
apt-key add gpg
# 获取 /etc/apt/trusted.gpg 中 docker 可以后8位字符 [0EBF CD88]
apt-key list
# 提取最后8个字符 [0EBF CD88]，去掉空格，然后用它来导入 /etc/apt/trusted.gpg.d 目录下专用文件中的 GPG 密钥：
apt-key export 0EBFCD88 | gpg --dearmour -o /etc/apt/trusted.gpg.d/debian-bookworm-docker-ce.gpg
```

验证您现在是否拥有带有指纹的密钥：

```bash
share apt-key fingerprint 0EBFCD88
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid             [ 未知 ] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```

:::

### 设置稳定版仓库镜像：

```bash
add-apt-repository "deb [arch=amd64] http://mirrors.ustc.edu.cn/docker-ce/linux/debian bookworm stable"
apt update
install docker-ce docker-ce-cli containerd.io -y
```
