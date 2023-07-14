---
title: PhpStorm
titleTemplate: Debian 教程
---

# {{ $frontmatter.title }}

## 安装 PhpStorm

这里只介绍手工配置安装

### 目录

> 下面假设根目录为： `/home/emad/JetBrains/`

```
JetBrains               部署根目录
├─app                   应用目录
│  ├─PhpStorm           PHP的IDE
│  ├─DataGrip           数据库管理工具
│  ├─ ...               更多应用
│
├─data                  应用数据目录
│  ├─PhpStorm           PhpStorm 应用数据
│  │  ├─stubs-zh        PhpStorm 中文版存根
│  │  ├─ ...
│  │
│  ├─DataGrip           DataGrip 应用数据
│  ├─ ...               更多应用数据
│
├─tools                 激活工具
│  ├─ja-netfilter.jar   激活程序
│  ├─config-jetbrains   激活配置目录
│  ├─logs-jetbrains     激活日志目录
│  └─ ...               没啥用可移除的
│
```

::: tip 激活工具
在项目中 [[点击下载]](/assets/debian/jetbrains/tools.tar.xz) 激活工具

:::

### 修改应用配置文件

::: details PhpStorm
::: code-group
<<<@/assets/debian/jetbrains/phpstorm/phpstorm64.vmoptions{ini} [phpstorm64.vmoptions]
<<<@/assets/debian/jetbrains/phpstorm/idea.properties{ini} [idea.properties]
:::

::: details DataGrip
::: code-group
<<<@/assets/debian/jetbrains/datagrip/datagrip64.vmoptions{ini} [datagrip64.vmoptions]
<<<@/assets/debian/jetbrains/datagrip/idea.properties{ini} [idea.properties]
:::

### JetBrains 系列激活码

<!--@include: @/assets/debian/jetbrains/code.md-->

::: tip 提示
推荐使用 jetbrains-toolbox 工具安装 PhpStorm 等 JetBrains 系列软件，不过遗憾的是 `PhpStorm 2023.1.3` 以后无法正常激活
:::

## 桌面文件

::: code-group
<<<@/assets/debian/jetbrains/desktop/phpstorm.desktop{ini} [PhpStorm]
<<<@/assets/debian/jetbrains/desktop/datagrip.desktop{ini} [DataGrip]
<<<@/assets/debian/jetbrains/desktop/clion.desktop{ini} [CLion]
:::

::: tip 桌面文件路径

| 路径                          | 说明     |
| ----------------------------- | -------- |
| ～/.local/share/applications  | 用户级别 |
| /usr/local/share/applications | 全部用户 |
| /usr/share/applications       | 全部用户 |

:::

## php 文件头部

PhpStorm 可以自定文件头部信息，支持设置 `默认` 和 `项目` 两种类型的文件头模板，例如：

::: code-group

```php [默认头模板]
// +----------------------------------------------------------------------
// | ${PROJECT_NAME} [ PHP is the best language for web programming ]
// +----------------------------------------------------------------------
// | Copyright (c) 2022-2023 linjialiang All rights reserved.
// +----------------------------------------------------------------------
// | Author: linjialiang <linjialiang@163.com>
// +----------------------------------------------------------------------
// | CreateTime: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND}
// +----------------------------------------------------------------------
```

```php [项目头模板]
// +----------------------------------------------------------------------
// | QyPHP [ 勤易极简 PHP 框架 ]
// +----------------------------------------------------------------------
// | Copyright (c) 2022-2023 linjialiang All rights reserved.
// +----------------------------------------------------------------------
// | Author: linjialiang <linjialiang@163.com>
// +----------------------------------------------------------------------
// | CreateTime: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND}
// +----------------------------------------------------------------------
```

:::

## 调试

这里只介绍 `使用浏览器调试` ，更多的 PHPSTORM 调试内容请查阅[官网说明](https://www.jetbrains.com/help/phpstorm/debugging-with-phpstorm-ultimate-guide.html)

### 1. 正确配置 xdebug 插件

具体内容请查阅[php 动态安装 pecl 扩展](./../../lnmp/php#动态安装-pecl-扩展)

### 2. 安装浏览器扩展

浏览器扩展名叫 `xdebug-helper`，支持 firefox、chrome、edge 浏览器

::: details 为 Chrome 配置 Xdebug 帮助程序

1. 从 Chrome 网上应用店安装 Chrome 的 Xdebug 帮助程序扩展程序。

2. 在 PhpStorm 中，通过单击工具栏 ![开始侦听 PHP 调试连接](/assets/debian/jetbrains/img/php_icons_debug_listen_off.svg) 按钮或菜单栏选择 `运行>开始侦听 PHP 调试连接`

3. 从浏览器端启动连接。单击浏览器工具栏上的 Xdebug 帮助程序图标以启动调试、分析或跟踪会话：

![xdebug help in chrome](/assets/debian/jetbrains/img/ps_xdebug_helper_chrome.png)

4. 通常，不需要进一步配置。如有必要，可以通过右键单击 Xdebug 帮助程序图标并从上下文菜单中选择选项来浏览其他设置。

:::

### 3. 配置调试端口

php.ini 配置的 xdebug 端口加入到 phpstorm 调试端口下，多个 php 版本端口设置不同时，用英文逗号 `,` 隔开

![配置调试端口](/assets/debian/jetbrains/img/01.png)

### 4. 配置 PHP 服务器

需要调试的站点，只有正确配置 PHP 服务器后，才能得到正常监听，具体如下：

![80端口](/assets/debian/jetbrains/img/02.png)

![其它端口](/assets/debian/jetbrains/img/03.png)

## 断点

断点是在特定点暂停程序执行的特殊标记。这使您可以检查程序状态和行为。断点可以很简单（例如，在到达某些代码行时挂起程序），也可以涉及更复杂的逻辑（检查其他条件、写入日志消息等）。

设置后，断点将保留在项目中，直到显式删除它，临时断点除外）。

::: tip 提示
如果带有断点的文件在外部进行了修改，例如，通过 VCS 更新或在外部编辑器中更改，并且行号已更改，则断点将相应地移动。请注意，PhpStorm 必须在进行此类更改时运行，否则它们将被忽视。
:::

### 1. 断点的类型

PhpStorm 中可用的断点类型 ：

- 行断点：到达设置断点的代码行时挂起程序。可以在任何可执行代码行上设置这种类型的断点。
- 方法断点：在进入或退出指定方法或其实现之一时挂起程序，允许您检查方法的进入/退出条件。
- 异常断点：引发程序或其子类时挂起程序。它们全局应用于异常条件，不需要特定的源代码引用 `Exception` 。

### 2. 设置断点

::: details 设置行断点
单击要设置断点的可执行代码行处的装订线。或者，将插入符号放在行上，然后按 `Ctrl+F8`

![设置行断点](/assets/debian/jetbrains/img/ps_debug_line_breakpoint.png)
:::

::: details 设置方法断点
单击声明方法的行处的装订线。或者，将插入符号放在行上，然后按 `Ctrl+F8`

![设置行断点](/assets/debian/jetbrains/img/ps_method_breakpoint.png)

或者，执行以下操作：

1. 按或选择“运行|从主菜单查看断点。Ctrl+Shift+F8
2. 在打开的“断点”对话框中，按或单击 “添加”按钮，然后选择“PHP 方法断点”。Alt+Insert
3. 在“添加方法断点”对话框中，指定类和方法，或要为其添加断点的普通函数。

:::

::: details 设置异常断点

1. 单击调试工具窗口左侧的 ![查看断点](/assets/debian/jetbrains/img/app_debugger_view_breakpoints.svg) 按钮或按 `Ctrl+Shift+F8`
2. 在断点对话框中，单击 `+` 按钮或按 `Alt+Insert`，然后选择 `PHP 异常断点` 或 `JavaScript 异常断点`：

![设置行断点](/assets/debian/jetbrains/img/ps_create_exception_breakpoint.png)

3. 在“添加异常断点”对话框中，指定库中或项目中的异常类。

> 有关详细信息，请参阅[使用 PHP 异常断点进行调试](https://www.jetbrains.com/help/phpstorm/debugging-with-php-exception-breakpoints.html) 。

:::

> 更多断点相关内容，请查阅[PhpStorm 官方的断点教程](https://www.jetbrains.com/help/phpstorm/using-breakpoints.html)

## 设置代理

PHPSTORM 可以设置代理，设置方式跟 firefox 类似

![设置行断点](/assets/debian/jetbrains/img/05.png)
