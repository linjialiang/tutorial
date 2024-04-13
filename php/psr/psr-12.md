---
title: 扩展编码风格指南
titleTemplate: PSR 教程
---

# 扩展编码风格指南

`PSR-12` 取代 `PSR-2` 成为新的扩展编码风格指南 ，`PSR-12` 遵守 `PSR-1(基本编码标准)`

该规范的目的是为了提供一套符合大众的，标准的代码格式化方案，让不同的开发者代码风格保持一致

::: details 此示例包含一些推荐规则作为快速概述：
<<<@/assets/php/psr/psr-12/01.php
:::

## 1. 总则

### 1.1 基本编码标准

代码必须遵循 `PSR-1` 中列出的所有规则

### 1.2 文件

1. 所有的 PHP 文件必须使用 `Unix LF`（linefeed）行结束
2. 所有的 PHP 文件必须以非空行结束，并以一个 `LF` 结束
3. 在只包含 PHP 的文件中必须 `省略` 结束的 `?>` 标签

### 1.3 代码行

这块主要是针对编辑器阅读习惯做的限制：

1. 不应该对行长度有硬性限制
2. 行长度的软限制必须为 120 个字符
3. 行的长度不应超过 80 个字符；字符超过该长度的行应拆分为多个后续行，每个行的字符长度都不能超过 80 个字符
4. 行尾不能有尾随空格
5. 可以添加空行以提高可读性并注释相关的代码块，除非明确禁止
6. 每行只能有 1 个语句

### 1.4 缩进

代码必须为每个缩进级别使用 4 个空格的缩进，并且不能使用缩进标签(`Tab`)

### 1.5 关键词和类型

1. PHP 的所有[[关键词]](https://www.php.net/manual/zh/reserved.keywords.php)和[[类型]](https://www.php.net/manual/zh/reserved.other-reserved-words.php)都必须使用小写。

2. PHP 未来版本中新加的所有关键词和类型也都必须使用小写。

3. 类型必须使用缩写

   ::: tip
   PHP 自身也不支持标量类型 (`bool` `int` `float` `string`) 使用别名
   :::

## 2. 类语句

这里介绍声明语句、命名空间语句以及导入语句

一个 PHP 文件的头部可能会包含多个块。

如果包含多个块，则每个块都必须用空白行和其他块分隔，并且块内不能包含空白行。

所有的块都必须按照下面的顺序排列，如果不存在该块则忽略。

1. PHP 文件开始标签： `<?php`
2. 文件级文档块
3. 一个或多个声明语句
4. 命名空间声明语句
5. 一个或多个基于类的 use 声明语句
6. 一个或多个基于函数的 use 声明语句
7. 一个或多个基于常量的 use 声明语句
8. 其余代码

::: tip
import 语句不能以前导反斜杠开头，因为它们必须始终完全合格。

也就是说 use 导入的类、函数、常量时，不能使用 `反斜杠开头`
:::

::: details 以下示例说明了所有块的完整列表：
<<<@/assets/php/psr/psr-12/01.php
:::

::: details 使用深度不能超过 2 层的复合命名空间

很少出现这种复合命名空间，因为现代框架都不会这样定义类的命名空间

::: code-group

```php [允许的最大混合深度]
use Vendor\Package\SomeNamespace\{
    SubnamespaceOne\ClassA,
    SubnamespaceOne\ClassB,
    SubnamespaceTwo\ClassY,
    ClassZ,
};
```

```php [不允许的混合深度]
use Vendor\Package\SomeNamespace\{
    SubnamespaceOne\AnotherNamespace\ClassA,
    SubnamespaceOne\ClassB,
    ClassZ,
};
```

:::

## 3. 类、属性和方法

术语`类`指的是所有 `类(class)`、`接口(interface)` 和 `trait(特征、代码复用)`

1. 任何注释和语句不得跟在其右花括号后的同一行

2. 当实例化一个类时，后面的圆括号必须写出来，即使没有参数传进其构造函数

   ```php
   new Foo();
   ```

### 3.01 继承和实现

- 关键字 `extends(继承)` 和 `implements(实现)` 必须在类名的同一行声明
- 类的左花括号必须另起一行
- 右花括号必须跟在类主体的下一行
- 类的左花括号必须独自成行，且不得在其上一行或下一行存在空行
- 右花括号必须独自成行，且不得在其上一行存在空行

```php
namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements \ArrayAccess, \Countable
{
    // 常量，属性，方法
}
```

::: details 对于接口实现
如果有接口，实现接口和继承父类可以分为多行，前者每行需缩进一次

当这么做时，第一个接口必须写在下一行，且每行必须只能写一个接口，每个后续行缩进一次

```php
namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements
    \ArrayAccess,
    \Countable,
    \Serializable
{
    // 常量，属性，方法
}
```

:::

### 3.02 实现 traits

::: code-group

```php [规则1]
// 在类里面用于实现 trait 的关键字 `use` 必须在左花括号的下一行声明
namespace Vendor\Package;

use Vendor\Package\FirstTrait;

class ClassName
{
    use FirstTrait; // 必须在类的左花括号的下一行声明
}
```

```php [规则2]
// 每个导入类的 trait 必须 每行一个包含声明，且每个包含声明 必须 有其 use 导入语句
namespace Vendor\Package;

use Vendor\Package\FirstTrait;
use Vendor\Package\SecondTrait;
use Vendor\Package\ThirdTrait;

class ClassName
{
    use FirstTrait;
    use SecondTrait;
    use ThirdTrait;
}
```

```php [规则3]
// 在类文件中，如果在使用’use Trait’之后没有其他内容了 ，类名右大括号必须另起一行
namespace Vendor\Package;

use Vendor\Package\FirstTrait;

class ClassName
{
    use FirstTrait;
}
```

```php [规则4]
// 如有其他内容，两者之间需空一行
namespace Vendor\Package;

use Vendor\Package\FirstTrait;

class ClassName
{
    use FirstTrait;

    private $property;
}
```

```php [规则5]
// 当使用 insteadof 和 as 运算符时，它们必须如图所示使用，注意缩进、间距和另起一行
class Talker
{
    use A;
    use B {
        A::smallTalk insteadof B;
    }
    use C {
        B::bigTalk insteadof C;
        C::mediumTalk as FooBar;
    }
}
```

:::

### 3.03 属性和常量

- 所有属性必须声明可见性
- 所有常量必须声明可见性
- 关键字 `var` 不得用于声明属性
- 每条声明语句不得声明多于一个属性
- 属性名不得用单个下划线开头表明其受保护的或私有的可见性。也就是说，一个下划线开头显然是没有意义的
- 类型声明和属性名之间必须有一个空格

::: details 一个属性声明看上去如下所示：

```php
namespace Vendor\Package;

class ClassName
{
    public $foo = null;
    public static int $bar = 0;
}
```

:::

### 3.04 方法和函数

- 所有的方法 必须 事先声明类型。
- 方法命名 一定不可 用单个下划线来区分是 protected 或 private 类型。也就是说，不要用一个没有意义的下划线开头。
- 方法和函数名称中，方法命名后面 一定不可 使用空格。方法开始的花括号 必须 写在方法声明后自成一行， 结束花括号也 必须 写在方法后面自成一行。开始左括号后和结束右括号前，都 一定不可 有空格符。

::: details 一个方法的声明应该如下所示。注意括号，逗号，空格和花括号的位置：

```php
namespace Vendor\Package;

class ClassName
{
    public function fooBarBaz($arg1, &$arg2, $arg3 = [])
    {
        // 方法主体
    }
}
```

::: tip 一个函数的声明应该如下所示。注意括号，逗号，空格和花括号的位置：

```php
function fooBarBaz($arg1, &$arg2, $arg3 = [])
{
    // 函数主体
}
```

:::

### 3.05 方法和函数参数

::: code-group

```php [规则1]
// 在参数列表中， 不得 在每个逗号前存在空格，且 必须 在每个逗号后有一个空格
// 方法和函数中带有默认值的参数 必须 放在参数列表的最后
namespace Vendor\Package;

class ClassName
{
    public function foo(int $arg1, &$arg2, $arg3 = [])
    {
        // 方法主体
    }
}
```

```php [规则2]
// 当参数列表分成多行时，右圆括号和左花括号 必须 放在同一行且单独成行，两者之间存在一个空格。
// 参数列表 可以 分为多行，每行参数缩进一次。当这么做时，第一个参数 必须 放在下一行，且每行 必须 只能有一个参数。
namespace Vendor\Package;

class ClassName
{
    public function aVeryLongMethodName(
        ClassTypeHint $arg1,
        &$arg2,
        array $arg3 = []
    ) {
        // 方法主体
    }
}
```

```php [规则3]
// 当你定义一个返回值类型声明时，冒号后面的类型声明 必须 用空格符隔开。冒号和声明 必须 在同一行，且跟参数列表后的结束括号之间没有空格。
declare(strict_types=1);

namespace Vendor\Package;

class ReturnTypeVariations
{
    public function functionName(int $arg1, $arg2): string
    {
        return 'foo';
    }

    public function anotherFunction(
        string $foo,
        string $bar,
        int $baz
    ): string {
        return 'foo';
    }
}
```

```php [规则4]
// 在可空类型声明中，问号和类型声明之间不能有空格。
// 当在参数之前使用引用运算符 & 时，引用运算符之后不能有空格，例如上面的示例。
declare(strict_types=1);

namespace Vendor\Package;

class ReturnTypeVariations
{
    public function functionName(?string $arg1, ?int &$arg2): ?string
    {
        return 'foo';
    }
}
```

```php [规则5]
// 可变参数声明的三个点和参数名称之间不能有空格：
public function process(string $algorithm, ...$parts)
{
    // 函数体
}
```

```php [规则6]
// 当同时使用引用运算符和可变参数运算符时，它们之间不能有任何空格：
public function process(string $algorithm, &...$parts)
{
    // 函数体
}
```

:::

### 3.06 修饰符

- 如果是 `abstract` 或 `final` ，那么方法和常量的访问控制声明必须是可见的
- 如果是 `static` ，该修饰符声明必须位于访问控制声明之后

```php
namespace Vendor\Package;

abstract class ClassName
{
    protected static $foo;

    abstract protected function zim();

    final public static function bar()
    {
        // 请求体
    }
}
```

::: tip 附录

| 访问控制  | 是否可见 |
| --------- | -------- |
| public    | 可见     |
| protected | 可见     |
| private   | 不可见   |

| 类型   | 修饰符                           |
| ------ | -------------------------------- |
| 类     | `abstract`、 `final`             |
| 类常量 | `final`                          |
| 类方法 | `abstract`、 `final` 和 `static` |

:::

### 3.07 方法和函数的调用

当我们在进行方法或者函数调用的时候，方法名或函数名与左括号之间不能出现空格，在右括号之后也不能出现空格，并且在右括号之前也不能有空格。在参数列表中，每个逗号前面不能有空格，每个逗号后面必须有一个空格。

```php
bar();
$foo->bar($arg1);
Foo::bar($arg2, $arg3);
```

参数列表可以分为多行，每行后面缩进一次。这样做时，列表中的第一项必须位于下一行，并且每一行必须只有一个参数。跨多个行拆分单个参数 (就像匿名函数或者数组那样) 并不构成拆分参数列表本身。

::: code-group

```php [规则1]
$foo->bar(
    $longArgument,
    $longerArgument,
    $muchLongerArgument
);
```

```php [规则2]
somefunction($foo, $bar, [
  // ...
], $baz);

$app->get('/hello/{name}', function ($name) use ($app) {
    return 'Hello ' . $app->escape($name);
});
```

:::

## 4. 流程控制

如下是主要的流程控制风格规则：

- 流程控制关键词之后 必须 要有一个空格
- 左括号后面 不能 有空格
- 右括号前面 不能 有空格
- 右括号与左大括号之间 必须 要有一个空格
- 流程主体 必须 要缩进一次
- 流程主体 必须 在左大括号之后另起一行
- 右大括号 必须 在流程主体之后另起一行

每个流程控制主体 必须 以封闭的括号结束。这将标准化流程结构，同时减少由于流程中添加新的内容而引入错误的可能性

### 4.01 if 结构

if 结构如下。注意括号，空格，和大括号的位置；else 和 elseif 都在同一行，和右大括号一样在主体的前面

```php
if ($expr1) {
    // if body
} elseif ($expr2) {
    // elseif body
} else {
    // else body;
}
```

应该 使用关键词 `elseif` 替换 `else if`，这样所有的控制关键词看起来都像单个词。

括号中的表达式 可能 会被分开为多行，每一行至少缩进一次。如果这样做，第一个条件 必须 在新的一行。右括号和左大括号 必须 在同一行，而且中间有一个空格。条件中间的布尔控制符 必须 在每一行的开头或者结尾，而不是混在一起。

```php
if (
    $expr1
    && $expr2
) {
    // if body
} elseif (
    $expr3
    && $expr4
) {
    // elseif body
}
```

### 4.02 switch 结构

switch 结构如下。

注意括号，空格和大括号的位置。case 必须 缩进一次从 switch 开始， break 关键词 (或者其他终止关键词) 必须 缩进和 case 主体保持一致。必须 要有一个像 // no break 这样的注释在不为空且不需要中断的 case 主体之中。

```php
switch ($expr) {
    case 0:
        echo 'First case, with a break';
        break;
    case 1:
        echo 'Second case, which falls through';
        // no break
    case 2:
    case 3:
    case 4:
        echo 'Third case, return instead of break';
        return;
    default:
        echo 'Default case';
        break;
}
```

括号中的表达式 可能 会被分开多行，每一行至少要缩进一次。如果这样做，第一个条件 必须 在新的一行。右括号和左大括号 必须 在同一行，而且中间有一个空格。条件中间的布尔控制符 必须 在一行的开头或者结尾，而不是混在一起。

```php
switch (
    $expr1
    && $expr2
) {
    // structure body
}
```
