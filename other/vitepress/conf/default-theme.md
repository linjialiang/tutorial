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

## socialLinks

-   Name: `SocialLink[]`

您可以定义此选项以在导航中显示带有图标的社交帐户链接

::: code-group

```ts [示例]
export default {
    themeConfig: {
        socialLinks: [
            { icon: 'github', link: 'https://github.com/linjialiang/php-environment.git' },
            {
                icon: {
                    svg: '<svg t="1685882013964" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="7153" width="600" height="600"><path d="M512 1024C229.222 1024 0 794.778 0 512S229.222 0 512 0s512 229.222 512 512-229.222 512-512 512z m259.149-568.883h-290.74a25.293 25.293 0 0 0-25.292 25.293l-0.026 63.206c0 13.952 11.315 25.293 25.267 25.293h177.024c13.978 0 25.293 11.315 25.293 25.267v12.646a75.853 75.853 0 0 1-75.853 75.853h-240.23a25.293 25.293 0 0 1-25.267-25.293V417.203a75.853 75.853 0 0 1 75.827-75.853h353.946a25.293 25.293 0 0 0 25.267-25.292l0.077-63.207a25.293 25.293 0 0 0-25.268-25.293H417.152a189.62 189.62 0 0 0-189.62 189.645V771.15c0 13.977 11.316 25.293 25.294 25.293h372.94a170.65 170.65 0 0 0 170.65-170.65V480.384a25.293 25.293 0 0 0-25.293-25.267z" fill="#d81e06" p-id="7154"></path></svg>',
                },
                link: 'https://gitee.com/linjialiang/php-environment.git',
            },
        ],
    },
};
```

```ts [SocialLink 结构]
interface SocialLink {
    icon: SocialLinkIcon;
    link: string;
}

type SocialLinkIcon =
    | 'discord'
    | 'facebook'
    | 'github'
    | 'instagram'
    | 'linkedin'
    | 'mastodon'
    | 'slack'
    | 'twitter'
    | 'youtube'
    | { svg: string };
```

:::
