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

::: danger 记得重启
安装依赖后记得重启，linux-headers 重启才能被 VMware 时被
:::
