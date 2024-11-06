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
