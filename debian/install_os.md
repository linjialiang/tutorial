---
title: 安装操作系统
titleTemplate: Debian 教程
---

# 安装操作系统

::: details 安装全部过程（截图）

在 vmware 安装发行版本 debian12，全部过程

![](/assets/debian/install_os/01.png)
![](/assets/debian/install_os/02.png)
![](/assets/debian/install_os/03.jpg)
![](/assets/debian/install_os/04.jpg)
![](/assets/debian/install_os/05.jpg)
![](/assets/debian/install_os/06.jpg)
![](/assets/debian/install_os/07.jpg)
![](/assets/debian/install_os/08.jpg)
![](/assets/debian/install_os/09.jpg)
![](/assets/debian/install_os/10.jpg)
![](/assets/debian/install_os/11.jpg)
![](/assets/debian/install_os/12.jpg)
![](/assets/debian/install_os/13.jpg)
![](/assets/debian/install_os/13-1.jpg)
![](/assets/debian/install_os/14.jpg)
![](/assets/debian/install_os/15.jpg)
![](/assets/debian/install_os/16.jpg)
![](/assets/debian/install_os/16-1.jpg)
![](/assets/debian/install_os/17.jpg)
![](/assets/debian/install_os/18.jpg)
![](/assets/debian/install_os/19.jpg)
![](/assets/debian/install_os/20.jpg)
![](/assets/debian/install_os/21.jpg)
![](/assets/debian/install_os/22.jpg)
![](/assets/debian/install_os/23.jpg)
![](/assets/debian/install_os/23-1.jpg)
![](/assets/debian/install_os/23-2.jpg)
![](/assets/debian/install_os/23-3.jpg)
![](/assets/debian/install_os/23-4.jpg)
![](/assets/debian/install_os/23-5.jpg)
![](/assets/debian/install_os/23-6.jpg)
![](/assets/debian/install_os/24.jpg)
![](/assets/debian/install_os/24-1.jpg)
![](/assets/debian/install_os/24-2.jpg)
![](/assets/debian/install_os/24-3.jpg)
![](/assets/debian/install_os/24-4.jpg)
![](/assets/debian/install_os/25.jpg)
![](/assets/debian/install_os/26.jpg)
![](/assets/debian/install_os/26-1.jpg)
![](/assets/debian/install_os/26-2.jpg)
![](/assets/debian/install_os/26-3.jpg)
![](/assets/debian/install_os/26-4.jpg)
![](/assets/debian/install_os/26-5.jpg)
![](/assets/debian/install_os/26-6.jpg)
![](/assets/debian/install_os/26-7-1.jpg)
![](/assets/debian/install_os/26-7-2.jpg)
![](/assets/debian/install_os/26-8.jpg)
![](/assets/debian/install_os/27.jpg)
![](/assets/debian/install_os/28.jpg)
![](/assets/debian/install_os/29.jpg)
![](/assets/debian/install_os/30.jpg)
![](/assets/debian/install_os/30-1.jpg)
![](/assets/debian/install_os/30-2.jpg)
![](/assets/debian/install_os/30-3.jpg)
![](/assets/debian/install_os/30-4.jpg)
![](/assets/debian/install_os/30-5.jpg)
![](/assets/debian/install_os/30-6.jpg)
![](/assets/debian/install_os/30-7.jpg)
![](/assets/debian/install_os/30-8.jpg)
![](/assets/debian/install_os/31.jpg)
![](/assets/debian/install_os/32.jpg)
![](/assets/debian/install_os/33.jpg)
![](/assets/debian/install_os/34.jpg)
![](/assets/debian/install_os/35.jpg)
![](/assets/debian/install_os/36.jpg)
![](/assets/debian/install_os/37.jpg)
![](/assets/debian/install_os/38.jpg)
![](/assets/debian/install_os/39.jpg)
![](/assets/debian/install_os/40.jpg)
![](/assets/debian/install_os/41.jpg)
![](/assets/debian/install_os/42.jpg)
![](/assets/debian/install_os/43.jpg)
:::

## 固件包

中科大镜像源里有对应版本的固件包

- 地址：http://mirrors.ustc.edu.cn/debian-cdimage/firmware/
- 说明：本地安装 `bookworm` 时，还是测试版本，固件包有点问题 U 盘安装时无法识别，最终我是用了 `bookworm` 版本的固件包

::: tip 提示
从 debian12 开始 官方 iso 已包含了非自由固件驱动包，

现在将 debian12 安装到你的电脑上，不需要再去下载非自由固件包了
:::

## 测试版 CD 下载

测试版 CD 只能在官网下载

- 地址：https://www.debian.org/devel/debian-installer/

## 软件源

| bookworm 版本             | 说明                               |
| ------------------------- | ---------------------------------- |
| bookworm                  | bookworm 软件源                    |
| bookworm-updates          | bookworm 发布的兼容更新            |
| bookworm-security         | bookworm 发布的安全更新（重要）    |
| bookworm-proposed-updates | 下一个小版本发布的更新（可选）     |
| bookworm-backports        | 向后移植的较新的软件包（可选）     |
| bookworm-backports-sloppy | 向后移植的草率的软件包（较不稳定） |

> 国内镜像

<<<@/assets/debian/apt/zkd-all.bash

::: tip 提示
debian12 稳定版在 wmware 上已经完成安装测试
:::

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
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=Debian
GRUB_CMDLINE_LINUX="quiet splash"
GRUB_CMDLINE_WINDOWS="quiet intel_iommu=on"
GRUB_EFI_DIR="/boot/efi"
GRUB_EFI_BOOTLOADER_ID="debian"
GRUB_DISABLE_OS_PROBER=false
```

```bash [更新引导]
update-grub
sync;sync;sync;reboot
```

:::

::: warning 警告
Debian 12 的引导默认开启了操作系统检查，在安装界面引导时就算为 Windows 目标平台安装了 GRUB，在启动时也无法正常显示 Windows 引导菜单
:::
