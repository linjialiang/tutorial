---
title: 基本编码标准
titleTemplate: PSR 教程
---

# {{ $frontmatter.title }}

PHP 代码应该严格使用这部分标准

## 概述

- 文件必须只使用 `<?php` 和 `<?=` 开始标签
- 文件必须只使用 `不带 BOM 的 UTF-8` 编码
- 文件应该声明符号（类、函数、常量等） 或引起副作用（例如，生成输出、更改.ini 设置等） 但不应该两者都做
- 命名空间和类必须遵循 PSR-4 自动加载
- 类名必须使用大写开头的驼峰命名规范（`StudlyCaps`）
- 类常量必须用大写字母声明，并带有下划线分隔符
- 方法名必须使用小写开头驼峰命名规范（`camelCase`）

## 文件

### 1. 标签

PHP 代码必须使用长标签(`<?php ?>`)或短 echo 标签(`<?= ?>`)

### 2. 字符编码

PHP 代码 必须 且只可使用 `不带 BOM 的 UTF-8` 编码

### 3. 副作用

文件应该只做 1 类事情：要不就只定义新的声明；要不就只执行逻辑操作（副作用）

::: tip 副作用
`副作用` 包括但不限于：

- 生成输出
- 显式的使用 require 或 include
- 连接到外部服务
- 修改 ini 设置
- 发出错误或异常
- 修改全局或静态变量
- 从文件阅读或写入文件等等

::: code-group
<<<@/assets/php/psr/psr-1/01.php [反例]
<<<@/assets/php/psr/psr-1/02.php [仅申明]
:::

## 命名空间和类名

命名空间和类名必须遵循 `PSR-4` 自动加载规范，即：

每个类都独立为一个文件，并且至少存在一个层级的名称空间

类名必须以类似 `StudlyCaps` 形式的大写开头的驼峰命名方式声明

::: info 名称空间层级

- 一层：如：`core` `think` `app`
- 两层：如：`core\route` `think\model` `app\controller`
- 三层：如：`app\test\controller` `app\admin\controller`

<<<@/assets/php/psr/psr-1/03.php

:::

## 类成员

类里有 3 中成员：

1. 类常量
2. 类属性（变量）
3. 类方法（函数）

::: details 类常量

类常量必须用大写字母声明，并带有下划线分隔符

```php
<?php
namespace Vendor\Model;

class Foo
{
    const VERSION = '1.0';
    const DATE_APPROVED = '2012-06-01';
}
```

:::

::: details 类属性
类属性尽可能使用首字母小写的驼峰法命名规则 `$camelCase`

如果类属性超过 3 个字母，可以使用小写字母+下划线的写法 `$under_score`
:::

::: details 类方法
类方法名必须使用首字母小写的驼峰法命名规则 `camelCase()`
:::
