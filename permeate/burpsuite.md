---
title: 安装 Burp Suite
titleTemplate: 渗透测试
---

# {{ $frontmatter.title }}

## 安装

去[官网](https://portswigger.net/burp/releases#professional)下载最新的 `Burp Suite Pro` 版本，双击安装即可

## Burpsuite_Pro 破解汉化补丁

::: info 激活

1. 先安装 Java JDK 18 以上版本
2. 将破解文件 Burploader.jar 放置于 BurpSuitePro.exe 同目录下（如：C:\Program Files\BurpSuitePro）
3. 将汉化文件 burpsuitloader-x.x.x-all.jar 放置于 BurpSuitePro.exe 同目录下
4. 双击 汉化文件 按 Run 开始激活流程 （注意勾选 `loader` `hanizfy` `auto start`）
5. 双击 汉化文件 打开

:::

::: tip 重新激活

1. 通过 cmd 打开激活工具

原因：勾选 `loader` `hanizfy` `auto start` 后，激活工具默认无法打开

```batch
cd C:\Program Files\BurpSuitePro
java -jar burpsuitloader-3.7.17-all.jar -r
```

> 提示：`-r` 选项可以打开激活工具

2. 按上述方法重新激活

:::
