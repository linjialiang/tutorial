---
title: 概述
titleTemplate: RIME 教程
---

# 中州韵输入法引擎

RIME／中州韵输入法引擎，是一个跨平台的输入法算法框架。

基于这一框架，Rime 开发者与其他开源社区的参与者在 Windows、macOS、Linux、Android 等平台上创造了不同的输入法前端实现。

| 平台    | 前端实现       | 是否官方 |
| ------- | -------------- | -------- |
| Windows | 小狼毫         | ☑️       |
| macOS   | 鼠须管         | ☑️       |
| Linux   | ibus-rime      | ☑️       |
| acOS    | XIME           | ❎       |
| macOS   | fcitx5-macos   | ❎       |
| Linux   | fcitx-rime     | ❎       |
| Linux   | fctec5-rime    | ❎       |
| 安卓    | 同文           | ❎       |
| 安卓    | fcitx5-android | ❎       |

Linux 上的输入法框架主要是 `Fcitx`、`Fcitx5` 和 `IBus` 三种，通过使用经验来讲：

-   IBus 对 GKT 包比较友好
-   Fcitx 对 QT 包比较友好
-   Fcitx5 作为 Fcitx 的更新版本，对 `GKT包` 和 `QT包` 都有较好的支持
-   针对 Wayland 桌面协议：暂时只有 Fcitx5 提供了基本支持

## 安装

### ibus-rime

Linux 下可以使用 IBus 输入法框架，安装前建议卸载 `Fcitx` 和 `Fcitx5` 相关包

::: code-group

```bash [卸载]
apt --purge autoremove fcitx*
```

```bash [安装]
apt install ibus-rime
```

:::

::: details 配置 ibus
![](/assets/debian/gui/004.png)
![](/assets/debian/gui/005.png)
:::

### fcitx5-rime

如果使用 `IBus` 输入法框架不满意，可以尝试 `Fcitx5` 输入法框架，安装前建议卸载 `Fcitx` 和 `IBus` 相关包

::: code-group

```bash [卸载]
apt --purge autoremove fcitx ibus* fcitx-*
```

```bash [安装]
apt install fcitx5 fcitx5-chinese-addons fcitx5-rime
```

:::

::: details 配置 fcitx5
![](/assets/debian/gui/016.png)
![](/assets/debian/gui/018.png)
:::

#### 界面主题

Debian12 为 fcitc5 输入法框架提供了一些不错的界面主题，这里使用了 fcitx5-material-color 包

```bash
apt install fcitx5-material-color -y
```

::: details 配置主题
![](/assets/debian/gui/017.png)
:::

### 小狼毫

小狼毫是 `中州韵输入法引擎(Rime)` 官方为 Windows 系统制作的输入法

去[中州韵输入法引擎官网](https://rime.im/) 下载最新的小狼毫输入法，双击 `weasel-*-installer.exe` 安装

::: tip 安装注意事项
请使用默认安装路径，为后续配置输入法做准备
:::

## 安装 rime-ice 词库

安装 rime-ice 词库非常简单，针对常见前端实现的安装方式如下：

::: details 操作前请先退出算法服务
![退出算法服务](/assets/rime/quit.png)
:::

::: code-group

```bash [ibus]
cd ~/.config/ibus
mv rime{,.bak}
git clone git@github.com:iDvel/rime-ice.git rime
# 国内镜像
# git clone https://madnesslin.coding.net/public/default/rime-ice/git rime
```

```bash [fcitx5]
cd ~/.config/fcitx5
mv rime{,.bak}
git clone git@github.com:iDvel/rime-ice.git rime
# 国内镜像
# git clone https://madnesslin.coding.net/public/default/rime-ice/git rime
```

```batch [小狼毫]
C:
cd %USERPROFILE%\AppData\Roaming
ren Rime Rime.bak
mv rime{,.bak}
git clone git@github.com:iDvel/rime-ice.git Rime
REM 国内镜像
REM git clone https://madnesslin.coding.net/public/default/rime-ice/git Rime
```

:::

::: details 操作完成，需重启算法服务
![退出算法服务](/assets/rime/restart.png)
:::

## RIME 重载配置

1. 切换到 Rime 输入法
2. 右键选择 `重新部署` 或 `部署`
3. 如不生效，可以重启系统尝试

::: details 重新部署
![重新部署](/assets/rime/reload.png)
:::

### 配置横排显示

1. 创建或修改 `~/.config/ibus/rime/build/ibus_rime.yaml` 文件

2. 添加或修改 `horizontal: true`

```yaml
style:
    horizontal: true
```

3. 重新部署 ibus-rime

### 使用 rime-ice 词库

```bash
cd ~/.local/share/fcitx5/
mv rime{,.bak}
# git clone git@github.com:iDvel/rime-ice.git rime
# 为了加速，这个是同步仓库，建议删除 .git 目录
git clone git@e.coding.net:madnesslin/default/rime-ice.git rime
```

> 点击部署 > 然后重启系统

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

::: details 默认使用英文

`rime_ice.schema.yaml` 文件，修改 ascii_mode 内容

```yaml
switches:
    - name: ascii_mode
      reset: 1 // [!code ++]
      states: [中, Ａ]
```

:::
