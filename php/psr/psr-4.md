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

    - 全限定类名 `必须` 拥有一个顶级命名空间名称，也称为供应商命名空间（vendor namespace）。
    - 全限定类名 `可以` 有一个或者多个子命名空间名称。
    - 全限定类名 `必须` 有一个最终的类名（我想意思应该是你不能这样 `\<NamespaceName>(\<SubNamespaceNames>)*\` 来表示一个完整的类）。
    - 下划线在全限定类名中没有任何特殊含义（在 `PSR-0` 中下划是有含义的）。
    - 全限定类名 `可以` 是任意大小写字母的组合。
    - 所有类名的引用 `必须` 区分大小写。

3.  全限定类名的加载过程

    - 在全限定的类名（一个「命名空间前缀」）中，一个或多个前导命名空间和子命名空间组成的连续命名空间，不包括前导命名空间的分隔符，至少对应一个「根目录」。
    - 「命名空间前缀」后面的相邻子命名空间与根目录下的目录名称相对应（且必须区分大小写），其中命名空间的分隔符表示目录分隔符。
    - 最终的类名与以 `.php` 结尾的文件名保持一致，这个文件的名字必须和最终的类名相匹配（意思就是如果类名是 `FooController`，那么这个类所在的文件名必须是 `FooController.php`）。

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

> 下面开始 PSR-4 说明文档

## 1. 概述

PSR-4 是为了给可交互的 PHP 自动加载器指定一个将命名空间映射到文件系统的规则，并且可以与其他 SPL 注册的自动加载器共存。PSR-4 不是 PSR-0 的替代品，而是对它的补充。
