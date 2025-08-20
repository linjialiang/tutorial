---
title: 安装操作系统Debian13
titleTemplate: Debian 教程
---

# 安装操作系统

::: details 安装全部过程（截图）

在 vmware 安装发行版本 debian13，全部过程

![](/assets/debian/install_os/01.png)

:::

## 测试版 CD 下载

测试版 CD 只能在官网下载

-   地址：https://www.debian.org/devel/debian-installer/

## 软件源

| trixie 版本             | 说明                               |
| ----------------------- | ---------------------------------- |
| trixie                  | trixie 软件源                      |
| trixie-updates          | trixie 发布的兼容更新              |
| trixie-security         | trixie 发布的安全更新（重要）      |
| trixie-proposed-updates | 下一个小版本发布的更新（可选）     |
| trixie-backports        | 向后移植的较新的软件包（可选）     |
| trixie-backports-sloppy | 向后移植的草率的软件包（较不稳定） |

> 国内镜像

<<<@/assets/debian/apt/debian13-zkd-all.bash

## 重装引导

::: code-group

```bash [安装必要软件包]
# rub-pc 主要用于处理PC（个人电脑）的启动引导
# efibootmgr 是一个用于管理 UEFI 启动项的工具
apt install grub-pc efibootmgr
```

```bash [安装GRUB引导]
# --target=x86_64-efi: 指定目标平台为x86_64架构的EFI系统。EFI（Extensible Firmware Interface）是一种用于在计算机启动时加载操作系统的标准接口。
# --efi-directory=/boot/efi: 指定EFI分区的挂载点。EFI分区是用于存储UEFI固件和启动加载程序的分区。
# --bootloader-id=custom: 设置自定义的启动标识符，用于区分不同的启动项。这个标识符将在GRUB菜单中显示，以便用户选择要启动的操作系统。
# --recheck: 重新检查系统的EFI支持情况。如果系统不支持EFI或者存在其他问题，这个选项可以帮助你解决问题。
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=custom --recheck
```

```bash [GRUB引导加载程序配置文件]
# /etc/default/grub
# 备注掉原来的全部代码...
# custom
GRUB_DEFAULT=0
# GRUB_DEFAULT=3 # 双系统，默认启动 Windows
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR=Debian
GRUB_CMDLINE_LINUX="quiet splash"
GRUB_CMDLINE_WINDOWS="quiet intel_iommu=on"
GRUB_EFI_DIR="/boot/efi"
GRUB_EFI_BOOTLOADER_ID="custom"
GRUB_DISABLE_OS_PROBER=false
```

```bash [更新引导]
update-grub
sync;sync;sync;reboot
```

:::

::: warning 警告
Debian 13 的引导默认开启了操作系统检查，在安装界面引导时就算为 Windows 目标平台安装了 GRUB，在启动时也无法正常显示 Windows 引导菜单
:::
