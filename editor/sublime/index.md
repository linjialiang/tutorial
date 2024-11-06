---
title: 概述
titleTemplate: Sublimt Text 教程
---

# 概述

## 安装

推荐使用便携版，需要下载 2 个软件：

1. [Sublime Text](http://www.sublimetext.com/download) 这是编辑器
2. [Sublime Merge](https://www.sublimemerge.com/download) 这是配套版本控制

```目录结构
├─ c:/sf/sublime    Sublime Text 根目录
| ├─ merge          Sublime Merge 根目录
|
```

## 破解

### Sublime Text 破解

Sublime Text 可以通过修改 `sublime_text.exe` 文件的 hex 值实现破解

1. `4180` 版本破解: `80 79 05 00 0F 94 C2` 改成 `C6 41 05 01 B2 00 90`

### Sublime Merge 破解

通过 Sublime Text 的插件 [sublime-self-patcher](https://github.com/n6333373/sublime-self-patcher) 实现破解：

1. 将 `SelfPatcher` 文件夹放入 `c:\sf\sublime\Data\Packages` 目录下
2. 重新打开 Sublime Text
3. `帮助` > `Patch External Sublime Text/Merge` 弹出一个文件选择框
4. 选择 `Sublime Merge.exe` 可执行文件
5. 会弹出一个信息框，请点击`确定`，通常就能激活成功！

## 插件

| 插件               | 描述          |
| ------------------ | ------------- |
| A File Icon        | 图标插件      |
| BracketHighlighter | 括号高亮插件  |
| LocalizedMenu      | 本地化菜单    |
| LSP                | 类 ide 插件   |
| LSP-html           | 支持 html     |
| LSP-css            | 支持 css      |
| LSP-typescript     | 支持 js 和 ts |
| LSP-json           | 支持 json     |
| LSP-intelephense   | 支持 php      |
| LSP-bash           | 支持 bash     |

### 插件详细说明

1. LocalizedMenu

   该插件含有 `多个国家的` 、 `多个版本号的` 本地化菜单，可以将不必要的本地化菜单全部删除，减少资源占用

2. LSP

   将 Sublime Text 改造成类 IDE 的插件框架，虽然功能不是很给力，但是作为辅助编辑器也足够使用了，

   - 该插件依赖较新版本的 nodejs
   - 每个子项目会在首次打开对应类型文件时静默执行 npm 下载依赖包
   - npm 镜像需要改成国内的，否则会无法下载依赖包

3. LSP-bash

   - 该插件不支持格式化

## 配置
