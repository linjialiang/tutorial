---
title: 使用 Volumes 持久存储
titleTemplate: Docker 教程
---

# 使用 Volumes 持久存储

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

## 使用卷启动容器

如果使用尚不存在的卷启动容器，Docker 会为您创建该卷。以下示例将卷 `myvol2` 挂载到容器中的 `/app/` 中。

下面的 `-v` 和 `--mount` 示例结果完全一致

::: code-group

```bash [--mount]
docker run -d \
--name devtest \
--mount source=myvol2,target=/app \
nginx:latest
```

```bash [-v]
docker run -d \
--name devtest \
-v myvol2:/app \
nginx:latest
```

:::

::: info 使用 `docker inspect devtest` 验证 Docker 是否创建了卷并正确装载了卷。查找 Mounts 部分：

```json
"Mounts": [
    {
        "Type": "volume",
        "Name": "myvol2",
        "Source": "/var/lib/docker/volumes/myvol2/_data",
        "Destination": "/app",
        "Driver": "local",
        "Mode": "z",
        "RW": true,
        "Propagation": ""
    }
],
```

这表明挂载是一个卷，它显示了正确的源和目标，并且装载是读写的。

:::

::: info 停止容器并删除卷。注意 卷删除是一个单独的步骤。

```bash
docker container stop devtest
docker container rm devtest
docker volume rm myvol2
```

:::

## 与 Docker Compose 一起使用

将卷（volume）与 Docker Compose 一起使用

::: info
以下示例显示了具有卷的单个 Docker 撰写服务：

```yaml
services:
  frontend:
    image: node:lts
    volumes:
      - myapp:/home/node/app
volumes:
  myapp:
```

首次运行 `docker compose up` 会创建一个卷。Docker 在随后运行命令时重复使用相同的卷。

您可以使用 docker volume create 直接在 Compose 外部创建卷，然后在 docker-compose.yml 中引用它，如下所示：

```yaml
services:
  frontend:
    image: node:lts
    volumes:
      - myapp:/home/node/app
volumes:
  myapp:
    external: true
```

:::

有关将卷与 Compose 配合使用的详细信息，请参阅“撰写”规范中的“卷”部分。

## 使用卷启动服务

启动服务并定义卷时，每个服务容器都使用自己的本地卷。如果使用 `local` 卷驱动程序，则任何容器都无法共享此数据。但是，某些卷驱动程序确实支持共享存储。

以下示例启动具有四个副本的 nginx 服务，每个副本使用名为 myvol2 的本地卷。

```bash
docker service create -d \
--replicas=4 \
--name devtest-service \
--mount source=myvol2,target=/app \
nginx:latest
```

使用 `docker service ps devtest-service` 验证服务是否正在运行：

```bash
docker service ps devtest-service

ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
4d7oz1j85wwn        devtest-service.1   nginx:latest        moby                Running             Running 14 seconds ago
```

您可以删除该服务以停止正在运行的任务：

```bash
docker service rm devtest-service
```

::: tip
删除服务不会删除服务创建的任何卷。卷删除是一个单独的步骤。
:::

## 服务的语法差异

`docker service create` 命令不支持 `-v` 或 `--volume` 标志。将卷装载到服务的容器中时，必须使用 `--mount` 标志。

## 使用容器填充卷

如果启动一个创建新卷的容器，并且该容器在要挂载的目录中有文件或目录，例如 `/app/` ，Docker 会将目录的内容复制到卷中。然后，容器装载并使用卷，使用该卷的其他容器也可以访问预填充的内容。

为了说明这一点，以下示例启动一个 `nginx` 容器，并使用容器的 `/usr/share/nginx/html` 目录的内容填充新卷 `nginx-vol` 。这是 Nginx 存储其默认 HTML 内容的地方。

::: code-group

```bash [--mount]
docker run -d \
--name=nginxtest \
--mount source=nginx-vol,destination=/usr/share/nginx/html \
nginx:latest
```

```bash [-v]
docker run -d \
--name=nginxtest \
-v nginx-vol:/usr/share/nginx/html \
nginx:latest
```

:::

运行这些示例之一后，运行以下命令来清理容器和卷。注意 卷删除是一个单独的步骤。

```bash
docker container stop nginxtest
docker container rm nginxtest
docker volume rm nginx-vol
```

## 使用只读卷

对于某些开发应用程序，容器需要写入绑定装载，以便将更改传播回 Docker 主机。在其他时候，容器只需要对数据的读取访问权限。多个容器可以装入同一卷。对于某些容器，可以同时将单个卷挂载为 `read-write` ，对于其他容器，可以挂载为 `read-only` 。

以下示例更改了上面的示例。它将目录挂载为只读卷，方法是将 `ro` 添加到容器内装入点之后的选项列表（默认为空）。如果存在多个选项，则可以使用逗号分隔它们。

::: code-group

```bash [--mount]
docker run -d \
--name=nginxtest \
--mount source=nginx-vol,destination=/usr/share/nginx/html,readonly \
nginx:latest
```

```bash [-v]
docker run -d \
--name=nginxtest \
-v nginx-vol:/usr/share/nginx/html:ro \
nginx:latest
```

:::

使用 docker inspect nginxtest 验证 Docker 是否正确创建了只读装载。查找 Mounts 部分：

```json
"Mounts": [
    {
        "Type": "volume",
        "Name": "nginx-vol",
        "Source": "/var/lib/docker/volumes/nginx-vol/_data",
        "Destination": "/usr/share/nginx/html",
        "Driver": "local",
        "Mode": "",
        "RW": false,
        "Propagation": ""
    }
],
```

停止并移除容器，然后移除卷。卷删除是一个单独的步骤。

```bash
docker container stop nginxtest
docker container rm nginxtest
docker volume rm nginx-vol
```

## 在计算机之间共享数据

构建容错应用程序时，可能需要配置同一服务的多个副本才能访问相同的文件。

![卷在计算机之间共享数据](/assets/docker/volumes-shared-storage.svg)

在开发应用程序时，有几种方法可以实现此目的。一种是向应用程序添加逻辑，以将文件存储在 Amazon S3 等云对象存储系统上。另一种方法是使用支持将文件写入外部存储系统（如 NFS 或 Amazon S3）的驱动程序创建卷。

卷驱动程序允许您从应用程序逻辑中抽象出底层存储系统。例如，如果您的服务使用带有 NFS 驱动程序的卷，则可以更新服务以使用其他驱动程序。例如，在不更改应用程序逻辑的情况下将数据存储在云中。

## 使用卷驱动程序

使用 `docker volume create` 创建卷时，或者启动使用尚未创建的卷的容器时，可以指定卷驱动程序。以下示例使用 `vieux/sshfs` 卷驱动程序，首先在创建独立卷时，然后在启动创建新卷的容器时。

::: tip 初始设置
以下示例假定您有两个节点，其中第一个节点是 Docker 主机，可以使用 SSH 连接到第二个节点。
在 Docker 主机上，安装 vieux/sshfs 插件：

```bash
docker plugin install --grant-all-permissions vieux/sshfs
```

:::

## 使用卷驱动程序创建卷

此示例指定 SSH 密码，但如果两台主机配置了共享密钥，则可以排除该密码。每个卷驱动程序可能具有零个或多个可配置选项，您可以使用 `-o` 标志指定每个选项。

```bash
docker volume create --driver vieux/sshfs \
-o sshcmd=test@node2:/home/test \
-o password=testpassword \
sshvolume
```

## 启动使用卷驱动程序创建卷的容器

以下示例指定 SSH 密码。但是，如果两台主机配置了共享密钥，则可以排除密码。每个卷驱动程序可能具有零个或多个可配置选项。

```bash
docker run -d \
--name sshfs-container \
--volume-driver vieux/sshfs \
--mount src=sshvolume,target=/app,volume-opt=sshcmd=test@node2:/home/test,volume-opt=password=testpassword \
nginx:latest
```

::: tip
如果卷驱动程序要求您传递任何选项，则必须使用 `--mount` 标志装载卷，而不是 `-v` 。
:::

## 创建用于创建 NFS 卷的服务

以下示例演示如何在创建服务时创建 NFS 卷。它使用 `10.0.0.10` 作为 NFS 服务器，使用 `/var/docker-nfs` 作为 NFS 服务器上的导出目录。请注意，指定的卷驱动程序是 `local` 。

::: code-group

```bash [NFSv3]
docker service create -d \
--name nfs-service \
--mount 'type=volume,source=nfsvolume,target=/app,volume-driver=local,volume-opt=type=nfs,volume-opt=device=:/var/docker-nfs,volume-opt=o=addr=10.0.0.10' \
nginx:latest
```

```bash [NFSv4]
docker service create -d \
--name nfs-service \
--mount 'type=volume,source=nfsvolume,target=/app,volume-driver=local,volume-opt=type=nfs,volume-opt=device=:/var/docker-nfs,"volume-opt=o=addr=10.0.0.10,rw,nfsvers=4,async"' \
nginx:latest
```

:::

## 创建 CIFS/Samba 卷

您可以直接在 Docker 中挂载 Samba 共享，而无需在主机上配置挂载点。

```bash
docker volume create \
--driver local \
--opt type=cifs \
--opt device=//uxxxxx.your-server.de/backup \
--opt o=addr=uxxxxx.your-server.de,username=uxxxxxxx,password=*****,file_mode=0777,dir_mode=0777 \
--name cif-volume
```

如果指定主机名而不是 IP，则需要 `addr` 选项。这允许 Docker 执行主机名查找。

## 块存储设备

您可以将块存储设备（如外部驱动器或驱动器分区）挂载到容器。以下示例演示如何创建文件并将其用作块存储设备，以及如何将块设备挂载为容器卷。

::: warning
以下过程只是一个示例。不建议将此处所示的解决方案作为常规做法。除非你对自己正在做的事情有信心，否则不要尝试这种方法。
:::

## 安装块设备的工作原理

在后台，使用 `local` 存储驱动程序的 `--mount` 标志调用 Linux `mount` 系统调用，并原封不动地转发传递给它的选项。Docker 不会在 Linux 内核支持的本机挂载功能之上实现任何其他功能。

如果您熟悉 Linux `mount` 命令，则可以按以下方式将 `--mount` 选项视为转发到 `mount` 命令：

```bash
mount -t <mount.volume-opt.type> <mount.volume-opt.device> <mount.dst> -o <mount.volume-opts.o>
```

若要进一步解释这一点，请考虑以下 `mount` 命令示例。此命令将 `/dev/loop5` 设备装载到系统上的路径 `/external-drive` 。

```bash
mount -t ext4 /dev/loop5 /external-drive
```

从正在运行的容器的角度来看，以下 `docker run` 命令实现了类似的结果。使用此 `--mount` 选项运行容器设置挂载的方式与执行上一示例中的 `mount` 命令的方式相同。

```bash
docker run \
--mount='type=volume,dst=/external-drive,volume-driver=local,volume-opt=device=/dev/loop5,volume-opt=type=ext4'
```

无法直接在容器内运行 mount 命令，因为容器无法访问 /dev/loop5 设备。这就是 docker run 命令使用 --mount 选项的原因。

## 示例：在容器中挂载块设备

以下步骤创建一个 `ext4` 文件系统并将其挂载到容器中。系统的文件系统支持取决于您使用的 Linux 内核的版本。

1. 创建一个文件并为其分配一些空间：

   ```bash
   fallocate -f 1G disk.raw
   ```

2. 在 disk.raw 文件上构建文件系统：

   ```bash
   mkfs.ext4 disk.raw
   ```

3. 创建循环设备：

   ```bash
   losetup -f --show disk.raw
   /dev/loop5
   ```

   ::: tip
   `losetup` 创建一个临时循环设备，该设备在系统重新启动后删除，或使用 `losetup -d` 手动删除。
   :::

4. 运行将循环设备挂载为卷的容器：

   ```bash
   docker run -it --rm \
   --mount='type=volume,dst=/external-drive,volume-driver=local,volume-opt=device=/dev/loop5,volume-opt=type=ext4' \
   ubuntu bash
   ```

   当容器启动时，路径 /external-drive 将主机文件系统中的 disk.raw 文件挂载为块设备。

5. 完成后，从容器中卸载设备后，分离环路设备以从主机系统中删除设备：

   ```bash
   losetup -d /dev/loop5
   ```

## 备份、还原或迁移数据卷

卷对于备份、还原和迁移非常有用。使用 `--volumes-from` 标志创建装载该卷的新容器。

### 备份卷

例如，创建一个名为 dbstore 的新容器：

```bash
docker run -v /dbdata --name dbstore ubuntu /bin/bash
```

::: info 在下一个命令中：

- 启动新容器并从 `dbstore` 容器装载卷
- 将本地主机目录挂载为 `/backup`
- 将 `dbdata` 卷的内容传递到 `/backup` 目录中的 `backup.tar` 文件的命令。

```bash
docker run --rm --volumes-from dbstore -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata
```

:::

当命令完成并且容器停止时，它会创建 `dbdata` 卷的备份。

### 从备份还原卷

使用刚刚创建的备份，可以将其还原到同一容器，也可以还原到在其他位置创建的另一个容器。

例如，创建一个名为 dbstore2 的新容器：

```bash
docker run -v /dbdata --name dbstore2 ubuntu /bin/bash
```

然后，解压缩新容器数据卷中的备份文件：

```bash
docker run --rm --volumes-from dbstore2 -v $(pwd):/backup ubuntu bash -c "cd /dbdata && tar xvf /backup/backup.tar --strip 1"
```

您可以使用上述技术，使用首选工具自动执行备份、迁移和还原测试。

### 删除卷

删除容器后，Docker 数据卷仍然存在。需要考虑两种类型的卷：

- 命名卷具有来自容器外部的特定源，例如 `awesome:/bar` 。
- 匿名卷没有特定的来源。因此，删除容器时，可以指示 Docker 引擎守护程序将其删除。

### 删除匿名卷

若要自动删除匿名卷，请使用 --rm 选项。例如，此命令创建一个匿名 /foo 卷。删除容器时，Docker 引擎会删除 /foo 卷，但不会删除 awesome 卷。

```bash
docker run --rm -v /foo -v awesome:/bar busybox top
```

::: tip
如果另一个容器将卷与 `--volumes-from` 绑定，则会复制卷定义，并且在删除第一个容器后，匿名卷也会保留。
:::

### 删除所有卷

要删除所有未使用的卷并释放空间，请执行以下操作：

```bash
docker volume prune
```
