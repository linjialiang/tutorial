---
title: 上一页和下一页
titleTemplate: VitePress 教程
prev:
    text: '进入徽章'
    link: './badge'
---

# 上一页和下一页

您可以自定义上一页和下一页的文本和链接（显示在文档页脚）。如果你想要一个不同的文本在那里比你在你的侧边栏。此外，您可能会发现禁用页脚或链接到未包含在侧边栏中的页面很有用。

## `prev`

-   Name: `prev`
-   Type: `string | false | { text?: string; link?: string }`

在 frontmatter 中可以指定上一页的链接以及显示的文本信息，如果没有在 frontmatter 中设置，文本和链接将从侧边栏配置中推断出来。示例如下：

::: code-group

```yaml [仅自定义文本]
---
prev: '进入徽章'
---
```

```yaml [自定义文本/链接]
---
prev:
    text: '进入徽章'
    link: './badge'
---
```

```yaml [隐藏上一页]
---
prev: false
---
```

:::

::: tip
`link` 支持站内和站外，支持相对路径和绝对路径
:::

## next

与 `prev` 相同，但为下一页。
