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

```bash
apt install ca-certificates gnupg2 -y
```
