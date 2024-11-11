# PowerShell

## 安装

下载并安装 [PowerShell 7.x](https://github.com/PowerShell/PowerShell/releases)

::: tip 创建配置文件

```ps1
New-Item -Path $PROFILE -Type File -Force
```

:::

### 常见指令

::: code-group

```ps1 [安装模块]
Install-Module -Name <模块名称> -Scope CurrentUser
# 安装名为PSReadLine的模块
Install-Module -Name PSReadLine -Scope CurrentUser
```

```ps1 [升级模块]
Update-Module -Name <模块名称> -Scope CurrentUser
# 升级名为PSReadLine的模块
Update-Module -Name PSReadLine -Scope CurrentUser
```

```ps1 [卸载模块]
Uninstall-Module -Name <模块名称> -AllVersions -Scope CurrentUser
# 卸载名为PSReadLine的模块
Uninstall-Module -Name PSReadLine -AllVersions -Scope CurrentUser
```

```ps1 [更多指令]
# 查找所有模块
Find-Module
# 查看已安装模块
Get-InstalledModule | Select-Object Name, Version, Summary
```

```md [常用参数说明]
1. `-Name`: 指定要操作的模块名称。
2. `-Scope`: 指定模块的安装范围。常用的选项有 CurrentUser（当前用户），AllUsers（所有用户）。
3. `-AllVersions`: 用于卸载时，指定是否删除该模块的所有版本。
```

:::

## 插件

PowerShell 需要安装几个插件用于提升体验，安装方式如下：

```ps1
# git 语法支持
Install-Module posh-git
# 命令行编辑体验增强
Install-Module PSReadLine -Force
```

### oh-my-posh

下载并安装 ohMyPosh 安装工具 [install-amd64.exe](https://github.com/JanDeDobbeleer/oh-my-posh/releases)

::: code-group

```ps1 [默认主题]
# notepad $PROFILE
oh-my-posh init pwsh | Invoke-Expression
```

```ps1 [指定主题]
# notepad $PROFILE
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\robbyrussell.omp.json" | Invoke-Expression
```

:::

## 配置案例

<<<@/assets/other/powershell/Microsoft.PowerShell_profile.ps1
