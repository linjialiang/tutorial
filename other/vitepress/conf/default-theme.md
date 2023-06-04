---
title: 默认主题配置
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

主题配置可让您自定义主题。

您可以通过配置文件中的 `themeConfig` 选项定义主题配置：

```ts
export default {
    lang: 'en-US',
    title: 'VitePress',
    description: 'Vite & Vue powered static site generator.',

    // Theme related configurations.
    themeConfig: {
        logo: '/logo.svg',
        nav: [],
        sidebar: {},
    },
};
```

::: warning 此页面上记录的选项仅适用于默认主题
不同的主题需要不同的主题配置。

使用自定义主题时，主题配置对象将传递给主题，以便主题可以基于它定义条件行为。
:::

## i18nRouting

详情请阅读 [[官方手册]](https://vitepress.dev/reference/default-theme-config#i18nrouting)

## LOGO 图标

-   Name: logo
-   Type: ThemeableImage

要在导航栏中显示的 logo 图标，紧挨着网站标题。

路径支持字符串或对象，以便为亮/暗模式设置不同的徽标。

::: code-group

```ts [示例]
export default {
    themeConfig: {
        logo: '/logo.svg',
    },
};
```

```ts [ThemeableImage 结构]
type ThemeableImage = string | { src: string; alt?: string } | { light: string; dark: string; alt?: string };
```

:::

## 默认站点标题

-   Name: siteTitle
-   Type: `string | false`

您可以自定义此项以替换导航中的默认站点标题（应用程序配置中的 title ）。

当设置为 false 时，导航中的标题将被禁用。当 logo 已包含网站标题文本时很有用。

```ts
export default {
    themeConfig: {
        siteTitle: 'Hello World',
    },
};
```
