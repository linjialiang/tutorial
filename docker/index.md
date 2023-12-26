---
title: Docker 概述
titleTemplate: Docker 教程
---

# 概述

学习 Docker 前需要了解几个概念

::: code-group

```md [Dokcer]
Docker 是一种运行于 `Linux` 和 `Windows` 上的软件，用于创建、管理和编排容器。
```

```md [容器]
容器跟虚拟机相似，主要区别在于：容器的运行不会独占操作系统。即，运行在相同宿主机上的容器是共享一个操作系统的，这样就能够节省大量的系统资源，如 CPU、RAM 以及存储。

同时容器还具有启动快和便于迁移等优势。将容器从笔记本电脑迁移到云上，之后再迁移到数据中心的虚拟机或者物理机之上，都是很简单的事情。
```

```md [Linux 容器]
实现容器所需的核心 Linux 内核技术被统称为 Linux 容器（Linux Container）

现代的容器技术起源于 Linux，它是很多人长期努力持续贡献的产物。举个例子，Google LLC 就贡献了很多容器相关的技术到 Linux 内核当中。没有大家的贡献，就没有现在的容器。
```

```md [Windows 容器]
实现容器所需的核心 Windows 内核技术被统称为 Windows 容器（Windows Container）

在过去的几年中，微软（Microsoft Corp.）致力于 Docker 和容器技术在 Windows 平台的发展。

`Windows 10` 和 `Windows Server 2016` 及以上版本可以使用 Windows 容器。为实现这个目标，微软跟 Docker 公司、社区展开了深入合作。

Windows 容器用户空间是通过 Docker 来完成与 Windows 容器之间交互的。
```

```md [Windows 容器 vs Linux 容器]
运行中的容器共享宿主机的内核，理解这一点是很重要的。这意味着一个基于 Windows 的容器化应用在 Linux 主机上是无法运行的。

简单地理解： Windows 容器需要运行在 Windows 宿主机之上，Linux 容器（Linux Container）需要运行在 Linux 宿主机上。

但是 ，Windows 版 Docker（由 Docker 公司提供的为 Windows 10 设计的产品）可以在 Windows 容器模式和 Linux 容器模式之间进行切换。
```

```md [Mac 容器现状]
迄今为止，还没有出现 Mac 容器（Mac Container）。

但是可以在 Mac 系统上使用 `Docker for Mac` 来运行 Linux 容器。这是通过在 Mac 上启动一个轻量级 Linux VM，然后在其中无缝地运行 Linux 容器来实现的。这种方式在开发人员中很流行，因为这样可以在 Mac 上很容易地开发和测试 Linux 容器。

即使是在 Windows 上，我们也是优先运行 Linux 容器，而不是直接运行 Windows 容器，毕竟 Linux 容器才是最稳定和高效的容器技术
```

```md [Kubernetes]
Kubernetes 是 容器之上的一个平台，现在采用 Docker 实现其底层容器相关的操作。

Kubernetes 也提供了一个可插拔的容器运行时接口 CRI。CRI 能够帮助 Kubernetes 实现将运行时环境从 Docker 快速替换为其他容器运行时。
```

:::

## 走进 Docker

Docker 是一种运行于 Linux 和 Windows 上的软件，用于创建、管理和编排容器。

Docker 是在 GitHub 上开发的 [Moby 开源项目](https://github.com/moby/moby) 的一部分。

Docker 公司，位于旧金山，是整个 `Moby 开源项目` 的维护者。Docker 公司还提供包含支持服务的商业版本的 Docker。

下面针对每个概念进行详细介绍。此外还包含对容器生态的探讨，以及对开放容器计划（Open Container Initiative, OCI）的介绍。

### 1. Docker 名称由来

`Docker` 一词来自英国口语，意为码头工人（Dock Worker），即从船上装卸货物的人。

### 2. Docker 运行时与编排引擎

多数技术人员在谈到 Docker 时，主要是指 Docker 引擎。

Docker 引擎是用于运行和编排容器的基础设施工具。是运行容器的核心容器运行时。

其他 Docker 产品都是围绕 `Docker 引擎` 进行开发和集成的。如下图所示：Docker 引擎位于中心，其他产品基于 Docker 引擎的核心功能进行集成。

![docker产品结构示意图](/assets/docker/001.png "docker产品结构示意图")
