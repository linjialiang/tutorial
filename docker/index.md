---
title: Docker 概述
titleTemplate: Docker 教程
---

# 概述

Docker 前需要了解几个概念：

::: code-group

```md [Dokcer]
Docker 是一种运行于 `Linux` 和 `Windows` 上的软件，用于创建、管理和编排容器。
```

```md [容器]
容器跟虚拟机相似，主要区别在于：容器的运行不会独占操作系统。

即，运行在相同宿主机上的容器是共享一个操作系统的，这样就能够节省大量的系统资源，如 CPU、RAM 以及存储。

同时容器还具有启动快和便于迁移等优势。

将容器从笔记本电脑迁移到云上，之后再迁移到数据中心的虚拟机或者物理机之上，都是很简单的事情。
```

```md [Linux 容器]
实现容器所需的核心 Linux 内核技术被统称为 Linux 容器（Linux Container）

现代的容器技术起源于 Linux，它是很多人长期努力持续贡献的产物。

举个例子，Google LLC 就贡献了很多容器相关的技术到 Linux 内核当中。

没有大家的贡献，就没有现在的容器。
```

```md [Windows 容器]
实现容器所需的核心 Windows 内核技术被统称为 Windows 容器（Windows Container）

在过去的几年中，微软（Microsoft Corp.）致力于 Docker 和容器技术在 Windows 平台的发展。

`Windows 10` 和 `Windows Server 2016` 及以上版本可以使用 Windows 容器。

为实现这个目标，微软跟 Docker 公司、社区展开了深入合作。

Windows 容器用户空间是通过 Docker 来完成与 Windows 容器之间交互的。
```

```md [Mac 容器现状]
迄今为止，还没有出现 Mac 容器（Mac Container）。

但是可以在 Mac 系统上使用 `Docker for Mac` 来运行 Linux 容器。

这是通过在 Mac 上启动一个轻量级 Linux VM，然后在其中无缝地运行 Linux 容器来实现的。

这种方式在开发人员中很流行，因为这样可以在 Mac 上很容易地开发和测试 Linux 容器。

即使是在 Windows 上，我们也是优先运行 Linux 容器，而不是直接运行 Windows 容器，毕竟 Linux 容器才是最稳定和高效的容器技术
```

```md [Kubernetes]
Kubernetes 是 容器之上的一个平台，现在采用 Docker 实现其底层容器相关的操作。

Kubernetes 也提供了一个可插拔的容器运行时接口 CRI。

CRI 能够帮助 Kubernetes 实现将运行时环境从 Docker 快速替换为其他容器运行时。
```

:::

::: tip Windows 容器 vs Linux 容器
运行中的容器共享宿主机的内核，理解这一点是很重要的。

这意味着一个基于 Windows 的容器化应用在 Linux 主机上是无法运行的。

简单地理解： Windows 容器需要运行在 Windows 宿主机之上，Linux 容器（Linux Container）需要运行在 Linux 宿主机上。

但是 ，Windows 版 Docker（由 Docker 公司提供的为 Windows 10 设计的产品）可以在 Windows 容器模式和 Linux 容器模式之间进行切换。
:::

## 走进 Docker

Docker 是一种运行于 Linux 和 Windows 上的软件，用于创建、管理和编排容器。

Docker 是在 GitHub 上开发的 [Moby 开源项目](https://github.com/moby) 的一部分。

Docker 公司，位于旧金山，是整个 `Moby 开源项目` 的维护者。Docker 公司还提供包含支持服务的商业版本的 Docker。

下面针对每个概念进行详细介绍。此外还包含对容器生态的探讨，以及对开放容器计划（Open Container Initiative, OCI）的介绍。

::: warning Docker 名称由来
`Docker` 一词来自英国口语，意为码头工人（Dock Worker），即从船上装卸货物的人。
:::

## Docker 运行时与编排引擎

多数技术人员在谈到 Docker 时，主要是指 Docker 引擎。

Docker 引擎是用于运行和编排容器的基础设施工具。是运行容器的核心容器运行时。

其他 Docker 产品都是围绕 `Docker 引擎` 进行开发和集成的。如下图所示：Docker 引擎位于中心，其他产品基于 Docker 引擎的核心功能进行集成。

![docker产品结构示意图](/assets/docker/001.png "docker产品结构示意图")

## Docker 开源项目（Moby）

`Docker` 一词也会用于指代开源 Docker 项目。其包含一系列可以从 Docker 官网下载和安装的工具，比如 `Docker 服务端` 和 `Docker 客户端`。

该项目在 2017 年于 Austin 举办的 DockerCon 上正式命名为 `Moby 项目`。

Moby 项目的目标是基于开源的方式，发展成为 Docker 上游，并将 Docker 拆分为更多的模块化组件。Moby 项目托管于 GitHub 的 [Moby 代码库](https://github.com/moby)，包括子项目和工具列表。核心的 Docker 引擎项目位于 GitHub 的 [moby/moby](https://github.com/moby/moby)，但是引擎中的代码正持续被拆分和模块化。

::: tip 展示 Moby 项目 的 Logo
![Moby的Logo](/assets/docker/002.png "Moby的Logo")
:::

## 容器生态

这里的生态是指，许多 Docker 内置的组件都可以替换为第三方的组件，网络技术栈就是一个很好的例子。Docker 核心产品内置有网络解决方案。但是网络技术栈是可插拔的，这意味着 Docker 内置的网络方案可以被替换为第三方的方案。许多人都会这样使用。

早期的时候，经常出现第三方插件比 Docker 提供的内置组件更好的情况。然而这会对 Docker 公司的商业模式造成冲击。毕竟，Docker 公司需要依靠盈利来维持基业长青。因此 `内置的组件` 变得越来越好用了。这也导致了生态内部的紧张关系和竞争的加剧。

也就是说，现在 Docker 内置的组件仍然是可插拔的，然而我们已经不需要使用第三方组件来替换了。

## 开放容器计划(OCI)

如果不谈及开放容器计划（The Open Container Initiative, OCI）的话，对 Docker 和容器生态的探讨总是不完整的。下图所示为 OCI 的 Logo：

![OCI 的 Logo](/assets/docker/003.png "OCI 的 Logo")

开放容器计划(OCI)是一个旨在对容器基础架构中的基础组件（如镜像格式与容器运行时，如果对这些概念不熟悉的话，不要担心，本书后续会介绍到它们）进行标准化的管理委员会。

到 2023/12/26 日 OCI 标准规范主要包含两部分：容器运行时标准（runtime spec）和容器镜像标准（image spec），这两个规范都以文档形式存在，是保证容器运行一致性的重要基础。

:::code-group

```md [运行时标准]
运行时标准定义了容器运行和执行的环境，包括文件系统、网络和存储等
```

```md [镜像标准]
镜像标准则规定了容器镜像的构建、传输和存储等细节。
```

:::

::: warning OCI 历史

一个名为 CoreOS 的公司不喜欢 Docker 的某些行事方式，因此它就创建了一个新的开源标准，称作“appc”，该标准涉及诸如镜像格式和容器运行时等方面。此外它还开发了一个名为 rkt （发音“rocket”）的实现。

两个处于竞争状态的标准将容器生态置于一种尴尬的境地。

这使容器生态陷入了分裂的危险中，同时也令用户和消费者陷入两难。虽然竞争是一件好事，但是标准的竞争通常不是。因为它会导致困扰，降低用户接受度，对谁都无益。

考虑到这一点，所有相关方都尽力用成熟的方式处理此事，共同成立了 OCI——一个旨在管理容器标准的轻量级的、敏捷型的委员会。

如今 OCI 在 Linux 基金会的支持下运作，Docker 公司和 CoreOS 公司都是主要贡献者。
:::
