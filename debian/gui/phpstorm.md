---
title: PhpStorm
titleTemplate: Debian 教程
---

# PhpStorm

## 安装 PhpStorm

这里只介绍手工配置安装

### 目录

> 项目根目录为： `~/jetbrains/`

```
jetbrains               部署根目录
├─app                   应用目录
│  ├─phpstorm           PHP的IDE
│  ├─ ...               更多应用
│
├─custom                应用数据目录
│  ├─phpstorm           PhpStorm 应用数据
│  │  ├─stubs           PhpStorm 中文版存根
│  │  ├─ ...
│  │
│  ├─ ...               更多应用数据
│
├─crack                 激活工具
│  ├─ja-netfilter.jar   激活程序
│  └─ ...
│
```

::: tip 激活工具
在项目中 [[点击下载]](/static/jetbrains/crack.7z) 激活工具
:::

::: warning 权限问题
值得一说的是：有一次我从 Windows 操作系统上下载源码包并分装完绿色版后压缩源码，拷贝到 Linux 系统上，解压时出现了权限不足问题。

我起先还以为是缺少 JAVA 的运行时环境(JER)，装了大半天，结果还是不行。后来才发现，其实只是权限不足导致的，事实上 JetBrains 每个 IDE 都自带了适配的 JER。
:::

### 修改应用配置文件

::: details PhpStorm
::: code-group
<<<@/assets/debian/jetbrains/phpstorm/phpstorm64.vmoptions{ini} [phpstorm64.vmoptions]
<<<@/assets/debian/jetbrains/phpstorm/jetbrains_client64.vmoptions{ini} [jetbrains_client64.vmoptions]
<<<@/assets/debian/jetbrains/phpstorm/idea.properties{ini} [idea.properties]
:::

::: details DataGrip
::: code-group
<<<@/assets/debian/jetbrains/datagrip/datagrip64.vmoptions{ini} [datagrip64.vmoptions]
<<<@/assets/debian/jetbrains/datagrip/idea.properties{ini} [idea.properties]
:::

::: details PyCharm
::: code-group
<<<@/assets/debian/jetbrains/pycharm/pycharm64.vmoptions{ini} [pycharm64.vmoptions]
<<<@/assets/debian/jetbrains/pycharm/idea.properties{ini} [idea.properties]
:::

### JetBrains 系列激活码

<!--@include: @/assets/debian/jetbrains/code.md-->

## 桌面文件

::: code-group
<<<@/assets/debian/jetbrains/desktop/clion.desktop{ini} [CLion]
<<<@/assets/debian/jetbrains/desktop/datagrip.desktop{ini} [DataGrip]
<<<@/assets/debian/jetbrains/desktop/goland.desktop{ini} [goland]
<<<@/assets/debian/jetbrains/desktop/phpstorm.desktop{ini} [PhpStorm]
<<<@/assets/debian/jetbrains/desktop/pycharm.desktop{ini} [PyCharm]
<<<@/assets/debian/jetbrains/desktop/idea.desktop{ini} [idea]
:::

| 桌面文件路径                  | 说明     |
| ----------------------------- | -------- |
| ～/.local/share/applications  | 用户级别 |
| /usr/local/share/applications | 全部用户 |
| /usr/share/applications       | 全部用户 |

::: tip 提示
`*.desktop` 文件里面的路径必须是基于根目录的绝对路径，使用家目录是不行的
:::

## php 文件头部

PhpStorm 可以自定文件头部信息，支持设置 `默认` 和 `项目` 两种类型的文件头模板，例如：

::: code-group

```php [默认头模板]
// +----------------------------------------------------------------------
// | ${PROJECT_NAME} [ PHP is the best language for web programming ]
// +----------------------------------------------------------------------
// | Copyright (c) 2022-present linjialiang All rights reserved.
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
// | Copyright (c) 2022-present linjialiang  All rights reserved.
// +----------------------------------------------------------------------
// | Author: linjialiang <linjialiang@163.com>
// +----------------------------------------------------------------------
// | CreateTime: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND}
// +----------------------------------------------------------------------
```

:::

## 调试

<!--@include: @/assets/debian/jetbrains/phpstorm/debug.md-->

## 设置代理

PHPSTORM 可以设置代理，设置方式跟 firefox 类似

![设置行断点](/assets/debian/jetbrains/img/05.png)

::: warning 其他配置
JetBrains 系列其他方面的配置，自己琢磨即可！
:::
