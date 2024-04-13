---
title: PER编码风格2.0
titleTemplate: PSR 教程
---

# PER 编码风格 2.0

该规范扩展并取代 `PSR-12` 成为新的扩展编码风格指南，遵守 `PSR-1(基本编码标准)`

`PSR-12` 于 2019 年被接受，此后对 PHP 进行了许多更改，这对编码风格指南有影响，因此才有了 `PER编码风格2.0`

::: details 此示例包含一些推荐规则作为快速概述：
<<<@/assets/php/psr/coding-style/01.php
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

### 1.6 尾随逗号

许多 PHP 结构允许用逗号分隔值序列， 并且最后一项可以具有可选的逗号。示例包括数组键/值对， 函数参数、闭包 `use` 语句、`match()`语句分支等。

如果该列表包含在一行中，则最后一项不得有尾随逗号。

如果列表被分成多行，那么最后一项必须有一个逗号。

::: details 以下是正确的逗号放置示例：
<<<@/assets/php/psr/coding-style/02.php
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
<<<@/assets/php/psr/coding-style/03.php
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
    // 组中的命名空间段太多
    SubnamespaceOne\AnotherNamespace\ClassA,
    SubnamespaceOne\ClassB,
    ClassZ,
};
```

:::

当希望在包含 PHP 外部标记的文件中声明严格类型时，严格类型的声明必须在文件的第 1 行并使用“PHP 的开始标记和结束标记”，如：

```php{1}
<?php declare(strict_types=1) ?> // [!code focus]
<html>
<body>
    <?php
        // ... additional PHP code ...
    ?>
</body>
</html>
```

`declare` 语句不能包含任何空格，并且必须是 `declare(strict_types=1)`，

另外`declare`允许块声明语句，块声明必须被格式化如下：

```php
declare(ticks=1) {
    // some code
}
```

## 3. 类、属性和方法

术语`类`指的是所有 `类(class)`、`接口(interface)` 和 `trait(特征、代码复用)`

1. 任何注释和语句不得跟在其右花括号后的同一行

2. 当实例化一个类时，后面的圆括号必须写出来，即使没有参数传进其构造函数

   ```php
   new Foo();
   ```

如果 class 不包含其他声明（例如，一个异常的存在只是为了用新类型扩展另一个异常）， 然后类的主体应该缩写为{}，并放置在与前一个符号相同的行上， 被一个空格隔开。举例来说：

```php
class MyException extends \RuntimeException {}
```

### 3.1 继承和实现

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

### 3.2 实现 trait

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

### 3.3 属性和常量

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

### 3.4 方法和函数

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

### 3.5 方法和参数

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

### 3.6 修饰符关键字

类、属性和方法具有许多关键字修饰符，这些修饰符改变 引擎和语言处理它们。如果存在，它们必须按以下顺序排列：

1. 继承修饰符: `abstract` 或 `final`
2. 可见性修改器：`public`、`protected` 或 `private`
3. 范围修改器：`static`
4. 突变修饰符：`readonly`
5. 类型声明
6. 名称

所有的关键字必须出现在同一行，并必须由空白符分隔。

::: details 以下是修饰符关键字用法的正确示例：
<<<@/assets/php/psr/coding-style/04.php
:::

::: tip 附录

> 属性/方法 通用访问控制修饰符：

| 访问控制  | 是否可见 |
| --------- | -------- |
| public    | 可见     |
| protected | 可见     |
| private   | 不可见   |

> 特定类型的修饰符：

| 类型   | 修饰符                         |
| ------ | ------------------------------ |
| 类     | `abstract/final` 和 `readonly` |
| 类方法 | `abstract/final` 和 `static`   |
| 类常量 | `final`                        |
| 类属性 | `static`、`readonly`           |

:::

### 3.7 方法和函数的调用

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

// 如果使用命名参数，则参数名称之间不得有空格 和冒号，并且在冒号和参数值之间必须有一个空格。举例来说：
somefunction($a, b: $b, c: 'c');
// 方法链接可以放在单独的行上，每一行缩进一次。当这样做时，第一个 方法必须在下一行。举例来说：
$someInstance
    ->create()
    ->prepare()
    ->run();
```

:::

### 3.8 函数可调用引用

一个函数或方法可以通过提供`...`代替参数来创建闭包。

如果是这样的话，`...`必须不包括任何空格之前或之后。也就是说，正确的格式是 `foo(...)`。

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

### 4.1 if 结构

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

### 4.2 switch 结构

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

类似地，一个 match 表达式看起来像下面这样。注意位置 圆括号、空格和大括号。

```php
<?php

$returnValue = match ($expr) {
    0 => 'First case',
    1, 2, 3 => multipleCases(),
    default => 'Default case',
};
```

### 4.3 while 语句

while 语句看起来像下面这样。请注意， 圆括号、空格和大括号。

```php
<?php

while ($expr) {
    // structure body
}
```

括号中的表达式可以拆分为多行，其中每行 后续行至少缩进一次。这样做的第一个条件是 必须在下一行。右括号和左大括号必须是 在它们之间有一个空间的直线上放置在一起。布尔 条件之间的运算符必须始终位于线，而不是两者的混合。

```php
<?php

while (
    $expr1
    && $expr2
) {
    // structure body
}
```

类似地，do while 语句看起来如下所示。注意位置 圆括号、空格和大括号。

```php
<?php

do {
    // structure body;
} while ($expr);
```

括号中的表达式可以拆分为多行，其中每行 后续行至少缩进一次。这样做的第一个条件是 必须在下一行。条件之间的布尔运算符必须 总是在开头或结尾，而不是两者兼而有之。举例来说：

```php
<?php

do {
    // structure body;
} while (
    $expr1
    && $expr2
);
```

### 4.4 for

for 语句看起来像下面这样。注意括号的位置， 空格和大括号。

```php
<?php

for ($i = 0; $i < 10; $i++) {
    // for body
}
```

括号中的表达式可以拆分为多行，其中每行 后续行至少缩进一次。当这样做时，第一个表达式 必须在下一行。右括号和左大括号必须是 在它们之间有一个空间的直线上放置在一起。举例来说：

```php
<?php

for (
    $i = 0;
    $i < 10;
    $i++
) {
    // for body
}
```

### 4.5 foreach

while 语句看起来像下面这样。请注意， 圆括号、空格和大括号。

```php
<?php

foreach ($iterable as $key => $value) {
    // foreach body
}
```

### 4.6 try, catch, finally

try-catch-finally 块看起来像下面这样。请注意， 圆括号、空格和大括号。

```php
<?php

try {
    // try body
} catch (FirstThrowableType $e) {
    // catch body
} catch (OtherThrowableType | AnotherThrowableType $e) {
    // catch body
} finally {
    // finally body
}
```

## 5. 运营商

操作符的样式规则按 arity（它们采用的操作数）分组。

当操作符周围允许有空格时，可以使用多个空格。 用于可读性目的。

这里没有描述的所有操作符都是未定义的。

### 6.1 一元运算符

递增/递减运算符之间不得有任何空格 operator 和 operator：

```php
$i++;
++$j;
```

类型转换操作符在括号内不能有任何空格，并且必须与它们所在的变量分隔开。 在一个空格上运行：

```php
$intValue = (int) $input;
```

### 6.2 二元操作符

所有二进制算术，比较，赋值，按位， 必须在逻辑、字符串和类型运算符之前， 至少有一个空格：

```php
if ($a === $b) {
    $foo = $bar ?? $a ?? $b;
} elseif ($a > $b) {
    $foo = $a + $b * $c;
}
```

### 6.3 三值算子

条件运算符，也简称为三元运算符，必须是 在?和:周围至少有一个空格 undefined 字符：

```php
$variable = $foo ? 'foo' : 'bar';
```

当省略条件运算符的中间操作数时， 必须遵循与其他二元比较运算符相同的样式规则：

```php
$variable = $foo ?: 'bar';
```

## 6. 关闭

闭包，也称为匿名函数，必须用空格声明 在 function 关键字之后，以及在 use 关键字之前和之后的空格。

左大括号必须在同一条线上，右大括号必须在同一条线上 身体后面的下一行。

参数列表的左括号后不能有空格 或变量列表，并且在右括号之前不能有空格 参数列表或变量列表。

在参数列表和变量列表中，每个变量之前都不能有空格。 逗号，每个逗号后面必须有一个空格。

带有默认值的闭包参数必须放在参数的末尾 名单

如果存在返回类型，则必须遵循与正常返回类型相同的规则 函数和方法;如果存在 use 关键字，冒号必须跟在后面 use 列出了两个字符之间没有空格的右括号。

闭包声明如下所示。请注意， 括号、逗号、空格和大括号：

```php
<?php

$closureWithArgs = function ($arg1, $arg2) {
    // body
};

$closureWithArgsAndVars = function ($arg1, $arg2) use ($var1, $var2) {
    // body
};

$closureWithArgsVarsAndReturn = function ($arg1, $arg2) use ($var1, $var2): bool {
    // body
};
```

参数列表和变量列表可以被分割成多行，其中 每个后续行缩进一次。执行此操作时， 列表必须在下一行，并且必须只有一个参数或变量 每一行。

当结束列表（无论是参数还是变量）被拆分时， 多行，必须放置右括号和左括号 在它们之间有一个空间。

下面是带和不带参数列表的闭包的示例， 跨多行拆分的变量列表。

<<<@/assets/php/psr/coding-style/05.php

请注意，当直接使用闭包时，格式规则也适用 在函数或方法调用中作为参数。

```php
<?php

$foo->bar(
    $arg1,
    function ($arg2) use ($var1) {
        // body
    },
    $arg3,
);
```

### 6.1 短期关闭

短闭包，也称为箭头函数，必须遵循相同的准则 和原则，如上面的长闭包，并添加以下内容。

`fn` 关键字后面不能有空格。

`=>`符号的前面和后面必须有一个空格。

在表达式末尾的空格前不能有空格。

表达式部分可以拆分到后续行。如果是，则必须包括`=>` 在第二行，必须缩进一次。

下面的例子展示了短闭包的常见用法。

```php
$func = fn(int $x, int $y): int => $x + $y;

$func = fn(int $x, int $y): int
    => $x + $y;

$func = fn(
    int $x,
    int $y,
): int
    => $x + $y;

$result = $collection->reduce(fn(int $x, int $y): int => $x + $y, 0);
```

## 7. 匿名类

匿名类必须遵循与闭包相同的指导方针和原则 在上面的部分。

```php
<?php

$instance = new class {};
```

左大括号可以与 class 关键字在同一行，只要 implements 接口的列表不换行。如果接口列表 在最后一次缠绕后，必须将支撑放置在紧接着最后一次缠绕的线上。 接口.

如果匿名类没有参数，则必须省略()后面的 class。举例来说：

<<<@/assets/php/psr/coding-style/06.php

## 8. 枚举

枚举（enums）必须遵循与类相同的准则，除非下面另有说明。

枚举中的方法必须遵循与类中的方法相同的准则。非公有方法必须使用 `private` 而不是 `protected`，因为枚举不支持继承。

当使用一个支持的枚举时，枚举名称和冒号之间不能有空格，并且必须只有一个 冒号和支持类型之间的空格。这与返回类型的样式一致。

枚举大小写声明必须使用 `PascalCase` 大写。枚举大小写声明必须在自己的行上。

枚举中的常量可以使用 `PascalCase` 或 `UPPER_CASE` 大写。`PascalCase` 是推荐的， 以便与案例声明保持一致。

::: details 下面的示例显示了一个典型的有效枚举：

```php
enum Suit: string
{
    case Hearts = 'H';
    case Diamonds = 'D';
    case Spades = 'S';
    case Clubs = 'C';

    const Wild = self::Spades;
}
```

:::

## 9. Heredoc 和 Nowdoc

这里不做说明

## 10. 数组

数组必须使用短数组语法声明。

```php
<?php

$arr = [];
```

数组必须遵循尾随逗号准则。

数组声明可以拆分为多行，其中每一行 缩进一次。当这样做时，数组中的第一个值必须在 下一行，每行只能有一个值。

当数组声明跨多行拆分时， 必须与等号放在同一行上。结束括号 必须放在最后一个值之后的下一行。不能有更多 每行赋值不止一个。赋值可以使用单行 或多条线。

::: details 以下示例显示了正确的数组用法：

```php
<?php

$arr1 = ['single', 'line', 'declaration'];

$arr2 = [
    'multi',
    'line',
    'declaration',
    ['values' => 1, 5, 7],
    [
        'nested',
        'array',
    ],
];
```

:::

## 11. 注解

### 11.1 基础知识

注解名称必须紧跟在开头的注解块指示符 `#[` 之后，不得有空格。

如果一个注解没有参数，则必须省略 `()` 。

结束注解块指示符 `]` 必须跟在注解名称的最后一个字符之后，或者 它的参数列表，前面没有空格。

构造 `#[...]` 在本文档中被称为“注解块”。

### 11.2 放置

类、方法、函数、常量和属性的注解必须在描述结构之前，将其放置在自己的线上。

对于参数上的注解，如果参数列表显示在单行上，注解必须与它所描述的参数放在一起，用一个空格分隔。 如果参数列表由于任何原因被分成多行，则注解必须放在 它自己的行位于参数之前，缩进方式与参数相同。如果参数列表 被分成多行，一个参数和注解之间可以包含一个空行 为了便于阅读，

如果一个注释文档块出现在一个结构上，并且该结构还包含一个注解，则注释块必须首先出现，然后是任何注解，最后是结构本身。不得有任何空白行在 docblock 和注解之间，或者注解和结构之间。

如果在多行上下文中使用了两个单独的注解块，则它们必须位于单独的行上，且不能为空他们之间的线。

### 11.3 复合属性

如果多个属性放在同一个属性块中，它们必须用逗号和空格分隔后面没有空格。如果属性列表由于某种原因被拆分为多行，则属性必须放在单独的属性块中。这些块本身可以包含多个属性，只要遵守此规则。

如果属性的参数列表由于任何原因被拆分为多行，则：

- 属性必须是其属性块中的唯一属性。
- 属性参数必须遵循为多行函数调用定义的相同规则。

### 11.4 例如

以下是有效属性用法的示例。

<<<@/assets/php/psr/coding-style/07.php
