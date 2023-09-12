---
title: 简单工厂模式
titleTemplate: PHP 设计模式教程
---

# {{ $frontmatter.title }}

简单工厂也称静态工厂，不属于 23 种经典设计模式。简单工厂是设计模式中最容易理解的一种设计模式了。

我们先展示简单工厂的具体实现代码：

::: code-group

<<<@/assets/php/design-patterns/simple-factory/Phone.php [手机接口]
<<<@/assets/php/design-patterns/simple-factory/Apple.php [苹果手机]
<<<@/assets/php/design-patterns/simple-factory/Huawei.php [华为手机]
<<<@/assets/php/design-patterns/simple-factory/SimpleFactory.php [简单工厂类]
<<<@/assets/php/design-patterns/simple-factory/run.php [执行脚本]

:::

代码就实现了创建对象的工作：根据我们传入的自定义标识符（apple、huawei），来返回对应类型的 Product 对象。

上面引入了 Phone 接口类，用于规定不同产品类型必须申明的方法

## 短信模块

场景：公司同时使用了阿里云、腾讯云、百度云 3 家的短信服务商，需要在不同场景下使用不同的短信服务商

::: code-group

<<<@/assets/php/design-patterns/simple-factory/sms/Message.php [短信接口]
<<<@/assets/php/design-patterns/simple-factory/sms/Ali.php [阿里云短信]
<<<@/assets/php/design-patterns/simple-factory/sms/Baidu.php [百度云手机]
<<<@/assets/php/design-patterns/simple-factory/sms/Tx.php [腾讯云手机]
<<<@/assets/php/design-patterns/simple-factory/sms/MessageFactory.php [简单工厂类]
<<<@/assets/php/design-patterns/simple-factory/sms/run.php [执行脚本]

:::

::: info 创建工厂方法一定要使用 static 吗？
答：需要常驻的全部 static，如果是按需实例化的就 `new 对象`，完了再使用 `->` 去调用方法
:::
