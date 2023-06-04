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

## 导航栏菜单

-   Name: nav
-   Type: `NavItem`

有关更多详细信息，请参阅默认主题：[[导航]](#navigation)

::: code-group

```ts [示例]
export default {
    themeConfig: {
        nav: [
            { text: 'Guide', link: '/guide' },
            {
                text: 'Dropdown Menu',
                items: [
                    { text: 'Item A', link: '/item-1' },
                    { text: 'Item B', link: '/item-2' },
                    { text: 'Item C', link: '/item-3' },
                ],
            },
        ],
    },
};
```

```ts [NavItem 结构]
type NavItem = NavItemWithLink | NavItemWithChildren;

interface NavItemWithLink {
    text: string;
    link: string;
    activeMatch?: string;
    target?: string;
    rel?: string;
}

interface NavItemChildren {
    text?: string;
    items: NavItemWithLink[];
}

interface NavItemWithChildren {
    text?: string;
    items: (NavItemChildren | NavItemWithLink)[];
    activeMatch?: string;
}
```

:::

## 侧边栏菜单

-   Name: `sidebar`
-   Type: `Sidebar`

侧边栏菜单项的配置。更多详细信息，请参阅默认主题：[[侧边栏]](#sidebar)

::: code-group

```ts [示例]
export default {
  themeConfig: {
    sidebar: [
      {
        text: 'Guide',
        items: [
          { text: 'Introduction', link: '/introduction' },
          { text: 'Getting Started', link: '/getting-started' },
          ...
        ]
      }
    ]
  }
}
```

```ts [NavItem 结构]
export type Sidebar = SidebarItem[] | SidebarMulti;

export interface SidebarMulti {
    [path: string]: SidebarItem[];
}

export type SidebarItem = {
    /**
     * The text label of the item.
     */
    text?: string;

    /**
     * The link of the item.
     */
    link?: string;

    /**
     * The children of the item.
     */
    items?: SidebarItem[];

    /**
     * If not specified, group is not collapsible.
     *
     * If `true`, group is collapsible and collapsed by default
     *
     * If `false`, group is collapsible but expanded by default
     */
    collapsed?: boolean;
};
```

:::

## aside

当前文件的标题列表导航

-   Name: `aside`
-   Type: `boolean | 'left'`
-   Default: `true`
-   可以通过每页的前言覆盖

| 选项     | 说明                   |
| -------- | ---------------------- |
| `false`  | 不展示标题列表导航     |
| `true`   | 标题列表导航呈现到右侧 |
| `'left'` | 标题列表导航呈现到左侧 |

## outline

大纲中要为页面显示的页眉级别

说人话：当前文件的标题列表导航展示 `h2-h6` 中哪些级别的标题

-   Name: `outline`
-   Type: `number | [number, number] | 'deep' | false`
-   Default: `2`
-   可以通过每页的前言覆盖

| 选项               | 说明                      |
| ------------------ | ------------------------- |
| `number`           | 没啥用                    |
| `[number, number]` | 没啥用                    |
| `'deep'`           | 列表展示 `h2-h6` 全部标题 |
| `false`            | 不展示                    |

## outlineTitle

可用于自定义右侧边栏的标题（在大纲链接的顶部）。这在用另一种语言编写文档时很有用。

```ts
export default {
    themeConfig: {
        outlineTitle: '大纲',
    },
};
```
