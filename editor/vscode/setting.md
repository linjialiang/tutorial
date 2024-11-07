---
title: 设置
titleTemplate: vscode 教程
---

# 设置

用户可以修改的设置主要有 3 种级别：

1. 用户级别设置
    - 本地用户设置
    - 远程用户设置(需安装远程插件)
2. 工作区级别设置

## 快捷方式

-   快捷键：`Ctrl+.`
-   命令行: `Ctrl+Shift+P` > 搜索 `settings`

## 用户设置

用户设置的配置文件存放在路径

-   Windows: `C:\Users\Administrator\AppData\Roaming\Code\User\settings.json`
-   Linux: `待补充`
-   远程用户设置(Linux): `~/.vscode-server/data/Machine/settings.json`

::: details 设置示例
<<< @/assets/vscode/settings.json
:::

## 工作区设置

路径：`{{项目根目录}}/.vscode/settings.json`

## prettier 配置文件

请阅读 [prettier 模块](./../../prettier/index.md)

## php 项目的工作区配置

<<< @/assets/vscode/php-settings.json
