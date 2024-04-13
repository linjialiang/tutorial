---
title: 基本编码标准
titleTemplate: PSR 教程
---

# 基本编码标准

PHP 代码应该严格使用这部分标准

## 概述

- 文件必须只使用 `<?php` 和 `<?=` 开始标签
- 文件必须只使用 `不带 BOM 的 UTF-8` 编码
- 文件应该声明符号（类、函数、常量等） 或引起副作用（例如，生成输出、更改 `.ini` 设置等） 但不应该两者都做
- 命名空间和类必须遵循 `PSR-4` 自动加载
- 类名必须使用大写开头的驼峰命名规范（`StudlyCaps`）
- 类常量必须用大写字母声明，并使用下划线分隔符
- 方法名必须使用小写开头驼峰命名规范（`camelCase`）

## 文件

### 1. 标签

PHP 代码必须使用长标签(`<?php ?>`)或短 echo 标签(`<?= ?>`)

### 2. 字符编码

PHP 代码 必须 且只可使用 `不带 BOM 的 UTF-8` 编码

### 3. 副作用

每个文件只做 1 类事：要嘛定义新的声明；要嘛就执行逻辑操作（副作用）

::: tip 副作用
`副作用` 包括但不限于：

- 生成输出
- 显式的使用 `require` 或 `include`
- 连接到外部服务
- 修改 `ini` 设置
- 发出错误或异常
- 修改全局或静态变量
- 读取或写入文件
- 其它逻辑操作

::: code-group
<<<@/assets/php/psr/psr-1/01.php [反例]
<<<@/assets/php/psr/psr-1/02.php [仅申明]
:::

## 命名空间和类名

命名空间和类名必须遵循 `PSR-4` 自动加载规范，即：

每个类都独立为一个文件，并且命名空间至少包含 1 层(顶级供应商)，也就是说不能是根命名空间

类名必须以大写开头的驼峰命名方式声明（`StudlyCaps`）

::: info 名称空间层级

- 一层：如：`core` `think` `app`
- 两层：如：`core\route` `think\model` `app\controller`
- 三层：如：`app\test\controller` `app\admin\controller`

<<<@/assets/php/psr/psr-1/03.php

:::

## 类成员

“类”在 PHP 中通常指所有的：类(class)、接口(interface)、特征(trait)

类有 3 种成员：`类常量` `类属性（类中的变量）` `类方法（类中的函数）`

::: details 类常量
类常量必须用大写字母声明，并使用下划线分隔符

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
类属性没有过多限制，可以 `$StudlyCaps`、`$camelCase` 或 `$under_score`，

需要确保在一定范围内使用统一的命名规则。

范围可以是：整个项目、单独的 composer 包、类级、方法级

::: tip 这里包括 类属性和变量
:::

::: details 类方法
类方法名必须使用首字母小写的驼峰法命名规则 `camelCase()`

::: tip 这里包括 类方法和函数
:::
