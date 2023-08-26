---
title: 拼音输入法
titleTemplate: Debian 教程
---

# {{ $frontmatter.title }}

Linux 上的输入法框架主要是 `fcitx` 和 `ibus` 两类

往常使用经验来讲： `ibus` 对 GKT+ 桌面比较友好， `fcitx` 对 QT+ 桌面比较友好

## ibus 输入法

安装前 ibus 输入法框架前，建议卸载 `fcitx` 和 `fcitx5` 相关输入法

::: code-group

```bash [卸载]
apt --purge autoremove fcitx*
```

```bash [安装]
apt install ibus-rime
```

:::

::: details 配置
![](/assets/debian/gui/004.png)
![](/assets/debian/gui/005.png)
:::

## 使用 rime-ice 词库

```bash
cd ~/.config/ibus
mv rime{,.bak}
git clone git@github.com:iDvel/rime-ice.git
```

> 点击部署 > 然后重启系统

## 配置横排显示

1. 创建或修改 `~/.config/ibus/rime/build/ibus_rime.yaml` 文件

2. 添加或修改 `horizontal: true`

```yaml
style:
  horizontal: true
```

3. 重新部署 ibus-rime

## 小狼毫输入法

小狼毫是 `中州韵输入法引擎(Rime)` 官方为 Windows 系统制作的输入法

### 安装

去[中州韵输入法引擎官网](https://rime.im/) 下载最新的小狼毫输入法，双击 `weasel-0.15.0.0-installer.exe` 安装

::: tip 安装注意事项
请使用默认安装路径，为后续配置输入法做准备
:::

### 配置

[雾凇拼音](https://github.com/iDvel/rime-ice) 是 Rime 的一个配置仓库，配置雾凇拼音如下：

::: details 1. Rime 退出算法服务
![配置解压到用户文件夹](/assets/debian/gui/007.png)
:::

::: details 2. 操作用户文件夹
进入 Rime 的 `用户文件夹` 并备份原始内容，路径如：`C:\Users\Administrator\AppData\Roaming\Rime`
:::

::: details 3. 下载雾凇拼音
去 git 仓库下载[最新源码包](https://github.com/iDvel/rime-ice/archive/refs/heads/main.zip)
:::

::: details 4. 将雾凇拼音的配置源码解压到 `用户文件夹`；

路径：C:\Users\Administrator\AppData\Roaming\Rime

![配置解压到用户文件夹](/assets/debian/gui/008.png)

> 用户文件夹最终效果

![用户文件夹最终效果](/assets/debian/gui/009.png)

:::

::: details 5. 重新部署
小狼毫退出算法服务后是无法使用重新部署的，最好的解决办法就是重启电脑
![基本不更新](/assets/debian/gui/011.png)
:::

::: details 6. 设置输入法；
![输入法设定](/assets/debian/gui/010.png)
![选中输入法](/assets/debian/gui/012.png)
![现代蓝界面](/assets/debian/gui/013.png)
:::

::: tip 到此完成！
:::

### 使用

通过快捷键 `F4` 或 `Ctrl - ~` 调出 Rime 方案选单，按需求选择

![Rime方案选单](/assets/debian/gui/015.png)
