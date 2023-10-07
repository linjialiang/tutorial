---
title: 安装操作系统
titleTemplate: Debian 教程
---

# 安装操作系统

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
