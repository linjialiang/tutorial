---
title: Sublime Text
titleTemplate: Debian 教程
---

# Sublime Text

## 安装

```bash
apt install ./sublime-text_build-4143_amd64.deb
```

## Windows

sublime text 4143 Windows 版本

| Desciption                       |   Offset   | Original             | Patched              |
| -------------------------------- | :--------: | -------------------- | -------------------- |
| Initial License Check            | 0x000A9864 | 55 41 57 41          | 48 31 C0 C3          |
| Persistent License Check 1       | 0x000071FE | E8 71 8B 20 00       | 90 90 90 90 90       |
| Persistent License Check 2       | 0x00007217 | E8 58 8B 20 00       | 90 90 90 90 90       |
| Disable Server Validation Thread | 0x000AB682 | 55 56 57 48 83 EC 30 | 48 31 C0 48 FF C0 C3 |
| Disable License Notify Thread    | 0x000A940F | 55                   | C3                   |
| Disable Crash Reporter           | 0x00000400 | 41                   | C3                   |

## Linux

sublime text 4143 Linux 版本

| Desciption                       |   Offset   | Original             | Patched              |
| -------------------------------- | :--------: | -------------------- | -------------------- |
| Initial License Check            | 0x003A31F2 | 55 41 57 41          | 48 31 C0 C3          |
| Persistent License Check 1       | 0x00399387 | E8 08 0E 12 00       | 90 90 90 90 90       |
| Persistent License Check 2       | 0x0039939D | E8 F2 0D 12 00       | 90 90 90 90 90       |
| Disable Server Validation Thread | 0x003A4E30 | 55 41 56 53 41 89 F6 | 48 31 C0 48 FF C0 C3 |
| Disable License Notify Thread    | 0x003A2E82 | 41                   | C3                   |
| Disable Crash Reporter           | 0x0038C9F0 | 55                   | C3                   |

## 注册码

```
—– BEGIN LICENSE —–
Mifeng User
Single User License
EA7E-1184812
C0DAA9CD 6BE825B5 FF935692 1750523A
EDF59D3F A3BD6C96 F8D33866 3F1CCCEA
1C25BE4D 25B1C4CC 5110C20E 5246CC42
D232C83B C99CCC42 0E32890C B6CBF018
B1D4C178 2F9DDB16 ABAA74E5 95304BEF
9D0CCFA9 8AF8F8E2 1E0A955E 4771A576
50737C65 325B6C32 817DCB83 A7394DFA
27B7E747 736A1198 B3865734 0B434AA5
—— END LICENSE ——
```

## 插件

使用 `Ctrl+Shift+P` 快捷键打开命令面板，选择或输入 `Install Package Control` 等待安装插件管理中心

插件管理中心安装完成以后，使用 `Install Package Control` 就可以调出插件列表，搜索或选择对应的插件进行安装即可

1. Emmet
2. ChineseLocalizations
3. SideBarMenuAdvanced
4. Save Copy As
5. ConvertToUTF8
6. BracketHighlighter
7. Vintageous
