---
title: 默认主题配置
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

主题配置可让您自定义主题。

您可以通过配置文件中的 `themeConfig` 选项定义主题配置：

```ts
export default {
  lang: "en-US",
  title: "VitePress",
  description: "Vite & Vue powered static site generator.",

  // Theme related configurations.
  themeConfig: {
    logo: "/logo.svg",
    nav: [],
    sidebar: {},
  },
};
```

::: warning 此页面上记录的选项仅适用于默认主题
不同的主题需要不同的主题配置。

使用自定义主题时，主题配置对象将传递给主题，以便主题可以基于它定义条件行为。
:::

## 总览

<!--@include: @/vitepress/theme/default/overview.md-->

<!--@include: @/vitepress/conf/frontmatter.md-->
