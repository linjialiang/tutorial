---
title: 快捷键
titleTemplate: vscode 教程
---

# 快捷键

## 自定义快捷键

| 按键                | 功能             |
| ------------------- | ---------------- |
| ctrl+shift+alt+p    | 项目从新窗口打开 |
| ctrl+k ctrl+shift+r | 重新加载窗口     |

::: details 源码
<<< @/assets/vscode/keybindings.json
:::

## 快捷键中文手册

::: details linux
[[点击下载PDF版本]](/assets/vscode/keyboard-shortcuts-linux.pdf)

![Linux快捷键中文手册](/assets/vscode/keyboard-shortcuts-linux.png)
:::

::: details Windows
[[点击下载PDF版本]](/assets/vscode/keyboard-shortcuts-windows.pdf)

![Windows快捷键中文手册](/assets/vscode/keyboard-shortcuts-windows.png)
:::

::: danger Linux 平台的 `向下/向上复制行` 快捷键需要自己添加

```json
[
    {
        "key": "shift+alt+up",
        "command": "editor.action.copyLinesUpAction",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "shift+alt+down",
        "command": "editor.action.copyLinesDownAction",
        "when": "editorTextFocus && !editorReadonly"
    }
]
```

:::
