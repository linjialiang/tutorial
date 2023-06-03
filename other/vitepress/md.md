---
title: MarkDown 扩展
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

VitePress 内置了 Markdown 扩展，下面是详细介绍。

## 锚链接

VitePress 可以使用 `markdown.anchor` 选项配置定位点的呈现，支持 `标头` 和 `普通行`

-   标头：允许您链接到标题为 `#root-dir` 而不是默认的 `#项目根目录`
-   普通行：无需标头，也可以快捷设置锚链接

::: code-group

```md [标头]
...

项目[根目录](#root-dir)和[源目录](#source-dir)。

### 项目根目录 {#root-dir}

...

### 项目源目录 {#source-dir}

...
```

```md [普通行]
...

项目根目录是 VitePress 尝试查找 [[.vitepress]](#vitepress-dir) 特殊目录的地方。

...

{#vitepress-dir}

.vitepress 目录是 VitePress 配置文件、开发服务器缓存、生成输出和可选主题自定义代码的默认保留位置
```

:::
