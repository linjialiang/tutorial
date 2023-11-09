---
title: VMware
titleTemplate: Debian 教程
---

# VMware

VMware 是 `.bundle` 格式的文件，安装特别简单

```bash
chmod +x ./VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle
./VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle
```

## VMware 依赖项

VMware 正常运行需要依赖 `gcc` 和 `linux-headers`

```bash
apt install gcc linux-headers-amd64 -y
```

## 安装必备插件

安装 `build-essential` 包，然后在打开 VMware 面包上点击 `install`，我们会自动将必备插件安装好

```bash
apt install build-essential -y
```

## 压缩虚拟磁盘

虚拟机内已经使用的空间，就算删除文件，容量也不能变小，只能通过指令在内部压缩

```bash
vmware-toolbox-cmd disk list                # 列出可用<mountpoint>
vmware-toolbox-cmd disk wipe <mountpoint>   # 擦除<mountpoint>未使用空间
vmware-toolbox-cmd disk shrinkonly          # 压缩磁盘
vmware-toolbox-cmd disk shrink <mountpoint> # 擦除<mountpoint>未使用空间并压缩磁盘
```
