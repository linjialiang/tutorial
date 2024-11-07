---
title: 插件
titleTemplate: vscode 教程
---

# 插件

在不深入了解 VSCode 的情况下，插件的内容会是最多的。

-   每个插件都有属于自己语法；
-   每个插件都有属于自己快捷键；
-   每个插件都有属于自己的作用。

## 插件列表

### 1. 通用插件

1. [Chinese (Simplified) ...](#chinese)
2. Dracula Official
3. [Material Icon Theme](#material-icon)
4. [GitLens — Git supercharged](#gitlens)
5. [Prettier - Code formatter](#prettier)
6. [Path Intellisense](#path-intellisense)
7. [Project Manager](#project-manager)
8. [Todo Tree](#todo-tree)
9. [IntelliCode](#intellicode)
10. [IntelliCode API Usage Examples](#intellicode-api-usage-examples)
11. [Code Spell Checker](#code-spell-checker)
12. [Better Align](#better-align)
13. [indent-rainbow](#indent-rainbow)
14. [Polacode-2022](#polacode-2020)
15. [Hex Editor](#hex-editor)
16. [Arm Assembly](#arm-assembly)
17. [VSCode Neovim](#Neovim)

### 2. 前端插件

1. [ESLint](#eslint)
2. [npm Intellisense](#npm-intellisense)
3. [WindiCSS IntelliSense](#windicss-intellisense)
4. [stylelint](#stylelint)

### 3. Vue3 插件

1. [Vue Language Features (Volar)](#volar)
2. [TypeScript Vue Plugin](#typescript-vue-plugin)

### 4. php 插件

1. [PHP Intelephense](#php-intelephense)
2. [PHP DocBlocker](#php-docblocker)
3. [PHP Namespace Resolver](#php-namespace-resolver)

### 5. 远程控制插件

1. [Remote - SSH](#remote-ssh)
2. Remote - SSH: Editing Configuration Files
3. Dev Containers : 对应 doker
4. Remote - Kubernetes : 对应 Kubernetes

::: info 说明
vscode 上优秀的插件有很多，这里不可能一一罗列，在日常工作中根据自己喜好去增删插件即可，这里只是给个建议
:::

## 一、通用插件

### 1. 中文语言包

插件名：`Chinese (Simplified) (简体中文) Language Pack for Visual Studio Code`

在 `编辑器命令面板` 中输入 `configure display language` 可以快速在中文、英文、其他语言包间切换

### 2. 主题

Dracula Official 是 vscode 里最稳的主题，喜欢其他主题也可以自行添加

### 3. 图标库

Material Icon Theme 是 vscode 里最受欢迎的图标库

### 4. GitLens

GitLens 极大地增强了 vscode 的版本控制能力

### 5. Prettier

Prettier 是一个代码格式化工具，默认支持格式化前端和 Markdown 文件，通过插件可以格式化跟多语言，比如：php、java 等

### 6. Path Intellisense

Path Intellisense 是路径智能感知插件

::: tip 激活路径补全

Path Intellisense 插件要激活路径补全，前面必须要带有引号：

1. 单引号： `'`
2. 双引号： `"`
3. 反引号： <code>`</code>

:::

::: details 禁用 vscode 自带路径智能感知

vscode 内置对 js、ts、markdown 启用路径感知，如果使用了 `Path Intellisense` 建议禁用它们

```json
// settings.json
{
    "typescript.suggest.paths": false,
    "javascript.suggest.paths": false,
    // 官方只提示禁用 ts和js，亲测markdown禁用也一切正常
    "markdown.suggest.paths.enabled": false
}
```

:::

::: details 映射

定义可用于使用绝对路径或与 webpack 解析选项结合使用的自定义映射

```json
{
    "path-intellisense.mappings": {
        // ThinkPHP 项目中，输入 `/static/` 时列出 `/public/static/` 的路径
        "/static/": "${workspaceFolder}/public/static/"
    }
}
```

:::

::: details TsConfig 支持

PathIntellisense 使用 `ts.config.compilerOptions.baseUrl` 作为映射，所以只需要在 tsconfig 配置 1 次即可，案例如下：

::: code-group

```text [目录结构]
src/module-a/foo.ts
src/module-b/foo.ts
```

```json [tsconfig 配置]
// tsconfig
{
    "baseUrl": "src"
}
```

```ts [用法]
{
    import {} from 'module-a/foo.ts';
}
```

```json [禁用 TsConfig 支持]
{
    // 将其设置为 true 来禁用对TsConfig 的支持
    "path-intellisense.ignoreTsConfigBaseUrl": true
}
```

:::

::: info
对于 path-intellisense 插件通常只需要知道这些，如需更多请查看[官方说明](https://github.com/ChristianKohler/PathIntellisense)
:::

### 7. Project Manager

vscode 下强大的项目管理插件

::: details 新增快捷键：

```json
// keybindings.json
[
    // 项目从新窗口打开
    {
        "key": "ctrl+shift+alt+p",
        "command": "projectManager.listProjectsNewWindow"
    }
]
```

:::

| 快捷键             | 功能             |
| ------------------ | ---------------- |
| `shift+alt+p`      | 快速切换项目     |
| `ctrl+shift+alt+p` | 项目从新窗口打开 |

### 8. Todo Tree

Todo Tree 是非常优秀 TODO 插件

::: details 修改配置文件，实现 TODO 标签的高亮：

```json
// settings.json
{
    "todo-tree.highlights.defaultHighlight": {
        "icon": "alert",
        "foreground": "#ecf5ff",
        "background": "#409eff",
        "rulerColour": "#409eff",
        "iconColour": "#409eff",
        "rulerLane": "full",
        "gutterIcon": true,
        "type": "tag"
    },
    "todo-tree.highlights.customHighlight": {
        "BUG": {
            "foreground": "#000000",
            "background": "#f56c6c",
            "rulerColour": "#f56c6c",
            "iconColour": "#f56c6c"
        },
        "TODO": {
            "icon": "check"
        },
        "FIXME": {
            "foreground": "#000000",
            "background": "#FFFF00",
            "rulerColour": "#FFFF00",
            "iconColour": "#FFFF00"
        }
    }
}
```

:::

### 9. IntelliCode

IntelliCode 可以为 `TypeScript/JavaScript` 提供 ai 辅助开发特性，基于对代码上下文的理解以及结合机器学习的见解

### 10. IntelliCode API Usage Examples

这是 IntelliCode 的配套插件

### 11. Code Spell Checker

Code Spell Checker 是一款拼写检查插件，目标是帮助捕获常见的拼写错误，同时保持低误报的数量，不支持中文拼音检查

::: tip
在配置文件里可以添加自己常用的关键词

如果经常使用中文拼音可以添加中文拼音的关键词
:::

### 12. Better Align

这是一个符号对齐插件，实用性很高

::: details 添加快捷键

```json
// keybindings.json
{
    "key": "ctrl+k ctrl+oem_plus",
    "command": "wwm.aligncode"
}
```

:::

| 快捷键          | 说明                 |
| --------------- | -------------------- |
| `ctrl+k ctrl+=` | 将所选行进行符号对齐 |

### 13. indent-rainbow

该插件可以高亮不同程度的缩进，缩进错误也会有特殊的警告背景色，需要的时候开启，不需要的时候禁用

### 14. Polacode-2020

这是一个代码截图插件，需要的时候开启，不需要的时候禁用

### 15. Hex Editor

Hex Editor 用于支持十六进制格式显示文件，并支持修改，需要的时候开启，不需要的时候禁用

### 16. Arm Assembly

这是对汇编语言的语法支持，需要的时候开启，不需要的时候禁用

### 17. VSCode Neovim

vim 引擎，具体要求：

1. Neovim >= 0.10.0
2. 配置里指向 Neovim 执行文件全路径

    ```json
    {
        // windows
        "vscode-neovim.neovimExecutablePaths.win32": "c:\\sf\\nvim-win64\\bin\\nvim.exe",
        // mac
        "vscode-neovim.neovimExecutablePaths.darwin": "/usr/local/bin/nvim",
        // linux
        "vscode-neovim.neovimExecutablePaths.linux": "/usr/local/bin/nvim"
    }
    ```

## 二、前端插件

### 1. ESLint

vscode 支持 ESLint，关于 ESLint 请到 [基础工具（暂无）] 里查阅

### 2. npm Intellisense

`npm Intellisense` 插件可以在 import 语句中自动提示 npm 模块

基本上属于零配置的，不过有两项值得注意：

1. 导入的命令，在代码段之后使用的换行符

    默认是 `;\r\n` ,根据需要我换成了 `;\n`

    ```json
    // settings.json
    "npm-intellisense.importLinebreak": ";\n",
    ```

2. 导入的命令，使用 `import` 语句而不是 `require()`

    默认是启用 `import`，假如你的环境不支持 es6，可以选择禁用

    ```json
    // settings.json
    "npm-intellisense.importES6": false,
    ```

::: tip
前端框架没有这个问题，因为都会通过 babel 转换，所以保持默认开启状态

npm Intellisense 与 Path Intellisense 插件是同一个作者
:::

### 3. WindiCSS IntelliSense

WindiCSS IntelliSense 为 Windi 开发提供自动完成、语法突出显示、代码折叠和构建等高级功能

我不怎么写前端，所以也没有去配置和安装该插件

### 4. stylelint

stylelint 提供的 css 类语法验证，比 vscode 自带的更好用，如果你是 CSS 重度用户，应该安装 stylelint

::: info 使用 stylelint 插件,建议禁用 vscode 自带的 css 类验证语法：

```json
// settings.json
{
    "css.validate": false,
    "less.validate": false,
    "scss.validate": false
}
```

:::

## 三、Vue3 插件

### 1. Volar

`Vue Language Features (Volar)` 是 vue3 必备插件

### 2. TypeScript Vue Plugin

`TypeScript Vue Plugin (Volar)` 是 vue3+typescript 必备插件

::: tip 提示
vue3 项目在使用了 volar 系列插件后，prettier 和 eslint 这两个插件可以不用配置，

因为 volar 自身对这两款插件进行了配置，如果使用了配置文件，它会覆盖 volar 自带的
:::

## 四、PHP 插件

### 1. PHP Intelephense

PHP Intelephense 为 vscode 提供 PHP 开发者的 IDE 工具

> 处理内置插件：

-   `ctrl+shift+x` 转到侧栏的扩展视图
-   搜索 `@builtin php` （vscode 内置 php 插件）
-   禁用 `PHP Language Features` （内置 php 语言高级功能）
-   启用 `PHP Language Basics`（内置 PHP 语言基本功能）

> 项目中指定配置：

::: details 针对当前项目的配置
<<< @/assets/vscode/php-settings.json

::: tip 提示
PHP Intelephense 插件不依赖于本地 php 环境
:::

### 2. PHP DocBlocker

一个简单、无依赖的 PHP 特定 `DocBlocking` 包

### 3. PHP Namespace Resolver

PHP 开发我更多的是使用 PhpStorm ，这款插件没怎么使用

## 五、远程控制

远程控制插件可以直接开启远程项目，比 `ftp/sftp` 这类插件好用了 N 倍

::: details 远程项目

1. 远程基础插件: Remote - SSH
2. 远程开发插件: Remote - SSH: Editing Configuration Files

:::

::: details 远程容器项目

1. 远程基础插件: Remote - SSH
2. 远程开发插件: Remote - SSH: Editing Configuration Files
3. docker 插件: Dev Containers
4. Kubernetes 插件: Remote - Kubernetes

:::

::: details ssh 配置文件
::: code-group
<<< @/assets/vscode/ssh/config-windows.ini [windows]
<<< @/assets/vscode/ssh/config-linux.ini [linux]
:::
