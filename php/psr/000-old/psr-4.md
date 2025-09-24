---
title: 自动加载
titleTemplate: PSR 教程
---

# 自动加载

## 1. 概述

PSR-4 描述了从文件路径中 `自动加载` 类的规范。

它拥有非常好的兼容性，并且可以在任何自动加载规范中使用，包括 `PSR-0`。

PSR-4 规范描述了放置自动加载文件（`vendor/autoload.php`）的位置。

## 2. 规范

1.  术语「class」指的是类（classes）、接口（interfaces）、特征（traits）和其他类似的结构。

2.  全限定类名具有以下形式：

    ```
    \<NamespaceName>(\<SubNamespaceNames>)*\<ClassName>
    ```

    -   全限定类名 `必须` 拥有一个顶级命名空间名称，也称为供应商命名空间（vendor namespace）。
    -   全限定类名 `可以` 有一个或者多个子命名空间名称。
    -   全限定类名 `必须` 有一个最终的类名（我想意思应该是你不能这样 `\<NamespaceName>(\<SubNamespaceNames>)*\` 来表示一个完整的类）。
    -   下划线在全限定类名中没有任何特殊含义（在 `PSR-0` 中下划是有含义的）。
    -   全限定类名 `可以` 是任意大小写字母的组合。
    -   所有类名的引用 `必须` 区分大小写。

3.  全限定类名的加载过程

    -   在全限定的类名（一个「命名空间前缀」）中，一个或多个前导命名空间和子命名空间组成的连续命名空间，不包括前导命名空间的分隔符，至少对应一个「根目录」。
    -   「命名空间前缀」后面的相邻子命名空间与根目录下的目录名称相对应（且必须区分大小写），其中命名空间的分隔符表示目录分隔符。
    -   最终的类名与以 `.php` 结尾的文件名保持一致，这个文件的名字必须和最终的类名相匹配（意思就是如果类名是 `FooController`，那么这个类所在的文件名必须是 `FooController.php`）。

4.  自动加载文件禁止抛出异常，禁止出现任何级别的错误，也不建议有返回值。

## 3. 案例

下表显示了与给定的全限定类名、命名空间前缀和根目录相对应的文件的路径。

| 完全限定类名                   | 命名空间前缀      | 基目录                   | 生成的文件路径                              |
| ------------------------------ | ----------------- | ------------------------ | ------------------------------------------- |
| `\Acme\Log\Writer\File_Writer` | `Acme\Log\Writer	` | `./acme-log-writer/lib/` | `./acme-log-writer/lib/File_Writer.php`     |
| `\Aura\Web\Response\Status`    | `Aura\Web`        | `/path/to/aura-web/src/` | `/path/to/aura-web/src/Response/Status.php` |
| `\Symfony\Core\Request`        | `Symfony\Core`    | `./vendor/Symfony/Core/` | `./vendor/Symfony/Core/Request.php`         |
| `\Zend\Acl`                    | `Zend`            | `/usr/includes/Zend/`    | `/usr/includes/Zend/Acl.php`                |

---

# PSR-4 自动加载规范 - 说明文档

## 1. 概述

PSR-4 是为了给可交互的 PHP 自动加载器指定一个将命名空间映射到文件系统的规则，并且可以与其他 SPL 注册的自动加载器共存。PSR-4 不是 PSR-0 的替代品，而是对它的补充。

## 2. 为什么需要它？

::: details PSR-0 的发展史
在 PHP 5.2 之前，PSR-0 的类命名标准和自动加载标准是以被广泛使用的 Horde/PEAR 约定为准。这个约定里要求将所有的 PHP 类文件放在一个主目录中， 并使用下划线连接的字符串来表示命名空间，如下所示：

```bash
/path/to/src/
    VendorFoo/
        Bar/
            Baz.php     # VendorFoo_Bar_Baz
    VendorDib/
        Zim/
            Gir.php     # VendorDib_Zim_Gir
```

随着 PHP 5.3 的发布以及新命名空间的广泛使用，现在 PSR-0 已经可以使用 Horde/PEAR 约定的下划线表示法或者新命名空间表示法。 它让下划线表示法作为新命名空间表示法的一个过渡，从而得到更好的兼容。

```bash
/path/to/src/
    VendorFoo/
        Bar/
            Baz.php     # VendorFoo_Bar_Baz
    VendorDib/
        Zim/
            Gir.php     # VendorDib_Zim_Gir
    Irk_Operation/
        Impending_Doom/
            V1.php
            V2.php      # Irk_Operation\Impending_Doom\V2
```

这种目录结构很大程度影响了 PEAR 安装器将源文件从 PEAR 包中迁移到一个主目录中。

:::

::: details 因 Composer 而来
在 Composer 中，包资源不再拷贝到某个单一的全局目录。从它们安装的位置引用它们，不需要移动。这就意味着使用 Composer 时 PHP 资源不像 PEAR 一样有「单一主目录」。取而代之的是多个目录；每个项目的每个包都在单独目录中。

为了符合 PSR-0 的需要，导致每个 Composer 包都类似下面这样：

```bash
vendor/
    vendor_name/
        package_name/
            src/
                Vendor_Name/
                    Package_Name/
                        ClassName.php       # Vendor_Name\Package_Name\ClassName
            tests/
                Vendor_Name/
                    Package_Name/
                        ClassNameTest.php   # Vendor_Name\Package_Name\ClassNameTest
```

「src」和「tests」目录必须包含开发商和包目录名。这是遵守 PSR-0 带来的结构。

许多人认为这种结构比需要的更深更重复。这一提议建议一个额外的或替代性的 PSR 将会更有益，所以我们有了类似以下的包结构：

```bash
vendor/
    vendor_name/
        package_name/
            src/
                ClassName.php       # Vendor_Name\Package_Name\ClassName
            tests/
                ClassNameTest.php   # Vendor_Name\Package_Name\ClassNameTest
```

这就需要将最初称为「基于包的自动加载」实现（对应于传统的「类 - 文件自动加载」）。

:::

::: details 面向 - 包的自动加载
通过扩展或修订 PSR-0 实现面向 - 包的自动加载非常困难，因为 PSR-0 不允许修改类名路径之间的任何部分。这意味着实现面向 - 包的自动加载要比 PSR-0 复杂的多，但是从另一方面来讲，它将使扩展包更加简洁。

在一开始的时候，以下规则是建议的:

1. 实现者必须使用两个以上的命名空间层级：一个 vendor 名，和该 vendor 内的包名。(这两个顶级名称组合被简称为 vendor-package 或 vendor-package namespace。)

2. 实现者必须允许 vendor-package namespace 与完全限定类名的其余部分之间的路径中缀。

3. vendor-package namespace 可以映射到任意目录。完全限定类名的其余部分，必须映射命名空间名 称到同名目录，类名必须映射到 `.php` 结尾的同名文件。

注意这意味着结束了在类名中下划线作为目录分隔符的做法。有人可能认为下划线应该被遵从因为它们出现 在 PSR-0 规范当中，但是在该文档中它们作为 PHP 5.2 或者更旧的版本的伪命名空间过渡的做法，所以此处删除他们也是可以接受的。

:::

## 3. 范围（Scope）

### 3.1 目标

-   保留实现者必须使用两个以上的命名空间层级的 PSR-0 规则：一个 vendor 名，和该 vendor 内的 包名。

-   允许 vendor-package namespace 与完全限定类名的其余部分的路径中缀。

-   允许 vendor-package namespace 可以映射到任何目录，也可能是多个目录。

-   结束遵从类名中下划线作为目录分隔符的做法。

### 3.2 非目标

-   为非类资源提供通用的转换规则

## 4. 方案选择

### 4.1 被选中的方案

本方案保留了 PSR-0 关键特性，同时消除了更深层次的目录结构。此外，指定了一些附加规则，使得操作起来更明确。

尽管不涉及目录映射，最终草案还是规定了自动加载器应该如何处理错误。具体来说，它禁止抛出异常和错误，主要有这两方面考虑：

PHP 中自动加载器设计是可堆叠的，如果一个自动加载器不能加载，则其他的仍有机会继续加载。若有其中一个自动加载器发生错误此过程将不会进行下去；

`class_exists()` 和 `interface_exists()` 允许『在尝试自动加载后仍然找不到类』的存在，一个用例是：若自动加载器抛出异常将使得 `class_exists()` 不可用，从互操作性的角度来看这是无法接受的。自动加载器在找不到类的情况下最好通过日志记录提供附加的调试信息，日志可以使用 PSR-3 兼容日志记录或类似的方案。

::: tip 优点:

-   较浅的目录结构；
-   文件位置更加固定；
-   不再使用类名中下划线作为目录分隔符；
-   更明确的互操作性实现

:::

::: tip 缺点:

-   不能像 PSR-0 仅仅通过类名就能确定它在文件系统的具体位置 (这种 “类 - 到 - 文件” 约定继承自 Horde/PEAR)。

:::

### 4.3 替代方案：拆分自动加载以及转换

Beau Simensen 跟其他人建议，转换算法可以从自动加载提案中分离出来以便转换规则可以被其他的提案引用。在完成分离它们的工作之后，会进行民意调查跟一些相关讨论。通过后，合并版本（即带转换规则的自动加载提案）会被显示为首选项。

::: tip 优点：
转换规则可以被其他提案引用
:::

::: tip 缺点：
不符合某民意调查的受访者跟合作者的意愿（就是要修改老代码，有些人怕麻烦）
:::

### 4.4 替代方案：使用更多命令式和叙事性语言

在多个 +1 选民听到他们支持这个想法但未同意（或理解）该提案的措辞后，赞助商撤回了第二次投票后，有一段时间，投票通过的提案得到了扩展。更大的叙事和更有必要的语言。少数参与者谴责这种方法。一段时间后，Beau Simensen 开始进行实验性修订，着眼于 PSR-0 。编辑和赞助商赞成采用这种更简洁的方法，并指导现在正在考虑的版本，由 Paul M. Jones 编写并为许多人做出贡献。

### 与 PHP 5.3.2 及更低版本的兼容性说明

5.3.3 之前的 PHP 版本不会删除前导命名空间分隔符，因此需要注意实施过程。无法删除前导命名空间分隔符可能会导致意外行为。

---

# PSR-4 自动加载规范 - 示例文档

下面的示例说明了符合 PSR-4 的代码：

::: code-group
<<<@/assets/php/psr/psr-4/01.php [闭包示例]
<<<@/assets/php/psr/psr-4/02.php [类示例]
<<<@/assets/php/psr/psr-4/03.php [单元测试]
:::
