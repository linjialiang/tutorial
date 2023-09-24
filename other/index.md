---
title: 概述
titleTemplate: 其他文档
---

# 其他文档概述

## 正则记录

::: details 127 网段正则匹配

正则匹配：127.<0-255>.<0-255>.<0-254>

```txt
^127(?:\.(?:(?:[1-9]?\d)|(?:1\d{2})|(?:2[0-4]\d)|(?:25[0-5]))){2}\.(?:(?:[1-9]\d?)|(?:1\d{2})|(?:2[0-4]\d)|(?:25[0-4]))$
```

:::

## PowerShell

### 安装 PowerShell

下载并安装 [PowerShell 7.x](https://github.com/PowerShell/PowerShell/releases)

::: info 创建配置文件

```ps1
New-Item -Path $PROFILE -Type File -Force
```

:::

### 常用插件

::: info 安装插件

```ps1
# git 语法支持
Install-Module posh-git
# 自动补全
Install-Module PSReadLine -Force
```

:::

:::details 配置插件

```ps1
# notepad $PROFILE
Import-Module posh-git
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
```

:::

### 安装 oh-my-posh

下载并安装 ohMyPosh 安装工具 [install-amd64.exe](https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v18.10.1/install-amd64.exe)

::: details 启用 oh-my-posh

```ps1
# notepad $PROFILE
# C:\Users\Administrator\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
# 未指定主题，使用默认主题
oh-my-posh init pwsh | Invoke-Expression
```

::: tip 指定主题

```ps1
# notepad $PROFILE
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\robbyrussell.omp.json" | Invoke-Expression
```

:::

::: details 完整的配置文件
<<<@/assets/other/powershell/Microsoft.PowerShell_profile.ps1
:::
