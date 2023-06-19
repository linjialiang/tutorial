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

如果容器生成非持久性状态数据，请考虑使用 `tmpfs 挂载` 来避免将数据永久存储在任何位置，并通过避免写入容器的可写层来提高容器的性能。

卷使用 `rprivate` 绑定传播，并且无法为卷配置绑定传播。

## 挂载卷的标志

卷可以选择 `-v` 或 `--mount` 作为挂载标志，`--mount` 更明确和冗长。

它们最大的区别是 `-v` 语法将所有选项组合在一个字段中，而 `--mount` 语法将它们分开。下面是每个标志的语法比较。

::: details -v 或 --volume
`-v` 或 `--volume` 由三个字段组成，用冒号（`:`）字符分隔。字段必须按正确的顺序排列，并且每个字段的含义并不明显。

- 对于命名卷，第一个字段是卷的名称，在给定主机上是唯一的。对于匿名卷，省略第一个字段。
- 第二个字段是文件或目录在容器中装载的路径。
- 第三个字段是可选的，并且是以逗号分隔的选项列表，例如 `ro` 。下面将讨论这些选项。

:::

::: details --mount
`--mount` ：由多个键值对组成，用逗号分隔，每个键值对由一个 `<key>=<value>` 元组组成。 `--mount` 语法比 `-v 或 --volume` 更详细，但键的顺序并不重要，并且标志的值更容易理解。

- 装载的 `type` ，可以是 `bind` 、 `volume` 或 `tmpfs` 。本主题讨论卷，因此类型始终为 `volume` 。
- 装载的 `source` 。对于命名卷，这是卷的名称。对于匿名卷，将省略此字段。可以指定为 `source` 或 `src` 。
- `destination` 将文件或目录在容器中装载的路径作为其值。可以指定为 `destination` 、 `dst` 或 `target` 。
- `readonly` 选项（如果存在）会导致绑定装载以只读方式装载到容器中。可以指定为 `readonly` 或 `ro` 。
- `volume-opt` 选项可以多次指定，它采用由选项名称及其值组成的键值对。

::: tip 来自外部 CSV 解析器的转义值

如果卷驱动程序接受逗号分隔的列表作为选项，则必须从外部 CSV 分析器中转义该值。要转义 `volume-opt` ，请用双引号（`"`）将其括起来，并用单引号（`'`）将整个挂载参数括起来。
例如， local 驱动程序接受装载选项作为 o 参数中的逗号分隔列表。此示例显示转义列表的正确方法。

```bash
docker service create \
    --mount 'type=volume,src=<VOLUME-NAME>,dst=<CONTAINER-PATH>,volume-driver=local,volume-opt=type=nfs,volume-opt=device=<nfs-server>:<nfs-path>,"volume-opt=o=addr=<nfs-address>,vers=4,soft,timeo=180,bg,tcp,rw"'
    --name myservice \
    <IMAGE>
```

:::

以下示例尽可能显示 `--mount` 和 `-v` 语法，首先使用 `--mount` 。

与绑定装载相反，卷的所有选项都可用于 `--mount` 和 `-v` 标志。与服务一起使用的卷仅支持 `--mount` 。

## 创建和管理卷

与绑定装载不同，您可以在任何容器的作用域之外创建和管理卷。

::: code-group

```bash [创建卷]
# 创建不支持多个
docker volume create my-vol
docker volume create my-vol1
docker volume create my-vol2
```

```bash [卷列表]
docker volume ls
```

```bash [检查卷]
root ➜ ~ docker volume inspect my-vol
[
    {
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/my-vol/_data",
        "Name": "my-vol",
        "Options": {},
        "Scope": "local"
    }
]
# 多个
root ➜ ~ docker volume inspect my-vol1 my-vol2
[
    {
        "CreatedAt": "2023-06-19T23:10:09+08:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/my-vol1/_data",
        "Name": "my-vol1",
        "Options": null,
        "Scope": "local"
    },
    {
        "CreatedAt": "2023-06-19T23:10:13+08:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/my-vol2/_data",
        "Name": "my-vol2",
        "Options": null,
        "Scope": "local"
    }
]
```

```bash [删除卷]
docker volume rm my-vol
# 多个
docker volume rm my-vol1 my-vol2
```

:::
