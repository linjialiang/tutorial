---
title: UML 类图
titleTemplate: PHP 设计模式教程
---

# {{ $frontmatter.title }}

学习设计模式前，最好先掌握 UML 类图

在 UML 的静态机制中类图是一个重点，它不但是设计人员关心的核心，更是实现人员关注的核心。建模工具也主要根据类图来产生代码。类图在 UML 的 9 个图中占据了一个相当重要的地位。

::: info 学习类图要掌握哪些内容？
类图是一个静态视图，它的核心包括 `类的基本表示` 以及 `类之间的关系表示`
:::

## 类的基本表示

这里的类是 `类`、`接口`、`包`、`代码复用（特征）` 的统称

::: details 类的基本表示法是三层矩形框

| 层级   | 内容          |
| ------ | ------------- |
| 第一层 | 类名          |
| 第二层 | 属性名/字段名 |
| 第三层 | 方法名/操作名 |

![三层](/assets/php/design-patterns/uml/01.svg)

::: tip
针对 PHP，我们统一使用属性名和方法名

其中属性又细分成 `变量` 和 `常量`
:::

::: details 访问控制

属性和方法前面的符号代表它们的访问控制（可见性）

| 符号 | 访问控制        | 描述   |
| ---- | --------------- | ------ |
| -    | private         | 私有   |
| #    | protected       | 受保护 |
| +    | public          | 公有   |
| ~    | package private | 包私有 |

![访问控制](/assets/php/design-patterns/uml/02.svg)

::: tip
在 PlantUML 里，属性的访问控制图标为空心；方法的访问控制图标为实体
:::

::: details PHP 的 UML 格式

```txt
属性： [{特征}] [访问控制] [类型] 属性名 [=默认值]
方法： [{特征}] [访问控制] 方法名([[类型] 参数 A, [类型]参数 B]) [返回类型]
```

::: tip PHP 特征

- 静态: `{static}` 下划线
- 抽象: `{abstract}` 斜体字
- 防止覆盖: `{final}` PlantUML 不支持 final，只能通过备注来表达

![final 特征](/assets/php/design-patterns/uml/05.svg)

:::

::: details PHP 中类的类型

| 关键词         | 描述            |
| -------------- | --------------- |
| class          | 类              |
| interface      | 接口类（斜体）  |
| abstract class | 抽象类（斜体）  |
| trait          | 代码复用-特征类 |
| final class    | 最终类          |

![类的类型](/assets/php/design-patterns/uml/03.svg)

::: tip 关于特征类和最终类
PlantUML 不支持 php 的特征类和最终类，只能通过类+模板 `<<trait>>`来表达

如果一个类被声明为 final，则不能被继承，所以这里称 `最终类`
:::

::: details 各种 `类` 的区别？

:::

## 类之间的关系表示
