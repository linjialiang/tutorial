---
title: fcitx5 拼音输入法框架
titleTemplate: Debian 教程
---

# 拼音输入法

Linux 上的输入法框架主要是 `fcitx` 和 `ibus` 两类，其中 fcitx 还有一个更新版本 `fcitx5`

使用 `ibus` 不是很满意，这次使用 `fcitx5`

## fcitx5 输入法

安装前 fcitx5 输入法框架前，建议卸载 `fcitx` 和 `ibus` 相关输入法

::: code-group

```bash [卸载]
apt --purge autoremove fcitx ibus* fcitx-*
```

```bash [安装]
apt install fcitx5 fcitx5-chinese-addons fcitx5-rime
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

3. 重新部署 fcitx5-rime
