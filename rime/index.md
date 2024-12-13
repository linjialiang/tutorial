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
![](/assets/rime/004.png)
![](/assets/rime/005.png)
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
![](/assets/rime/016.png)
![](/assets/rime/018.png)
:::

#### 界面主题

Debian12 为 fcitc5 输入法框架提供了一些不错的界面主题，这里使用了 fcitx5-material-color 包

```bash
apt install fcitx5-material-color -y
```

::: details 配置主题
![](/assets/rime/017.png)
:::

### 小狼毫

小狼毫(weasel)是 `中州韵输入法引擎(RIME)` 官方为 Windows 系统制作的输入法前端实现

去[中州韵输入法引擎官网](https://rime.im/) 下载最新的小狼毫输入法，双击 `weasel-*-installer.exe` 安装

::: tip 安装注意事项
请使用默认安装路径，为后续配置输入法做准备
:::

## 词库

这里推荐 rime-ice 词库，该词库完整并且安装很方便，针对常见前端实现的安装方式如下：

::: details 操作前，请先退出算法服务
![退出算法服务](/assets/rime/quit.png)
:::

::: code-group

```bash [ibus]
cd ~/.local/share/ibus/
mv rime{,.bak}
git clone git@github.com:iDvel/rime-ice.git rime
# 国内镜像
# git clone https://madnesslin.coding.net/public/default/rime-ice/git rime
```

```bash [fcitx5]
cd ~/.local/share/fcitx5/
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

## 重载配置

1. 切换到 Rime 输入法
2. 右键选择 `重新部署` 或 `部署`
3. 如不生效，可以重启系统尝试

::: details 重新部署
![重新部署](/assets/rime/reload.png)
:::

## 自定义配置

::: code-group
<<<@/assets/rime/default.custom.yaml [default.custom.yaml]
<<<@/assets/rime/weasel.custom.yaml [weasel.custom.yaml]
:::
