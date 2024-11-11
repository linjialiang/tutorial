# PowerShell

## 安装

下载并安装 [PowerShell 7.x](https://github.com/PowerShell/PowerShell/releases)

::: tip 创建配置文件

```ps1
New-Item -Path $PROFILE -Type File -Force
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
