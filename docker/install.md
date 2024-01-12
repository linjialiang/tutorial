---
title: Docker安装
titleTemplate: Docker 教程
---

# Docker 安装

Docker 可以安装在 Windows、Mac，当然还有 Linux 之上。除此之外还可以在云上安装，除了前面提到的各种安装场景之外，读者还可以选择不同方式完成 Docker 安装，包括手工安装、通过脚本方式安装和通过向导方式安装等。

安装 Docker 的场景和方式简直是数不胜数。不过整体上 Docker 的安装其实都很简单的。

::: tip 本章主要介绍了几种重要的安装方式：

1. Windows 开发环境安装 Docker
2. Linux 部署环境安装 Docker
3. Docker 引擎升级
4. Docker 存储驱动的选择

:::

## 在 Windows 上安装 Docker

在 Windows 上可以直接使用 [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/) 来快速安装：

::: details 安装截图
![](/assets/docker/004.png)
![](/assets/docker/005.png)
![](/assets/docker/006.png)
![](/assets/docker/007.png)
![](/assets/docker/008.png)
:::

::: details 什么是 Docker Desktop ？
Docker Desktop 是适用于 Mac、Linux 或 Windows 环境的一键安装应用程序，让您可以构建、共享和运行容器化应用程序和微服务。

它提供了一个简单的 GUI（图形用户界面），让您可以直接从计算机管理容器，应用程序和图像。您可以单独使用 Docker Desktop，也可以将其作为 CLI 的补充工具。

Docker Desktop 减少了在复杂设置上花费的时间，因此您可以专注于编写代码。它负责端口映射，文件系统问题和其他默认设置，并定期更新错误修复和安全更新。

开发环境
:::

## 在 Linux 终端 上安装 Docker Engine

Docker 当前有两个引擎版本可供选择：社区版（Community Edition，CE）和企业版（Enterprise Edition，EE）。

通常我们都会选择免费的社区版 Docker 引擎。

::: tip docker 一键安装命令

```bash
curl -fsSL https://get.docker.com | bash -s docker--mirror Aliyun
```

:::
