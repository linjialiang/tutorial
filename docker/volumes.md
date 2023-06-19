---
title: 使用 Volumes 持久存储
titleTemplate: Docker 教程
---

# {{ $frontmatter.title }}

卷(volumes)是持久保存由 Docker 容器生成和使用的数据类型的首选机制。虽然绑定挂载(Bind mounts)取决于主机的目录结构和操作系统，但卷完全由 Docker 管理。与绑定挂载相比，卷有几个优点：

- 卷比绑定挂载更易于备份或迁移。
- 您可以使用 Docker CLI 命令或 Docker API 管理卷。
- 卷适用于 Linux 和 Windows 容器。
- 卷可以在多个容器之间更安全地共享。
- 卷驱动程序允许您在远程主机或云提供商上存储卷，以加密卷的内容或添加其他功能。
- 新卷的内容可以由容器预填充。
- Docker Desktop 上的卷比来自 Mac 和 Windows 主机的绑定挂载具有更高的性能。

此外，卷通常是比将数据持久保存在容器的可写层中更好的选择，因为卷不会增加使用它的容器的大小，并且卷的内容存在于给定容器的生命周期之外。
