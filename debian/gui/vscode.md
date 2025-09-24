---
title: VSCode
titleTemplate: Debian 教程
---

# VSCode

## 安装

```bash
dpkg -i ./code_1.80.1-1689183569_amd64.deb
```

## 注释 apt 源

安装 vsocde 的时候，apt 里会生成微软的 vscode 源，速度比较满，如果不想每次 update 时，卡一会可以先关闭，等需要升级 vscode 时再打开

```bash
# vim /etc/apt/sources.list.d/vscode.list

### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out this entry, but any other modifications may be lost.
# deb [arch=amd64,arm64,armhf] http://packages.microsoft.com/repos/code stable main
```

## 配置

::: code-group
<<<@/assets/editor/vscode/settings.json [用户配置参考]
<<<@/assets/editor/vscode/keybindings.json [快捷键配置参考]
:::
