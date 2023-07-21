---
title: VMware
titleTemplate: Debian 教程
---

# {{ $frontmatter.title }}

VMware 是 `.bundle` 格式的文件，安装特别简单

```bash
chmod +x ./VMware-Workstation-Full-17.0.2-21581411.x86_64.bundle
./VMware-Workstation-Full-17.0.2-21581411.x86_64.bundle
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
