---
title: 侧边栏
titleTemplate: VitePress 教程
---

# 侧边栏

侧边栏（`Sidebar`）是文档的主要导航块。您可以在 `themeConfig.sidebar` 中配置侧边栏菜单。

```ts
export default {
    themeConfig: {
        sidebar: [
            {
                text: 'Guide',
                items: [
                    { text: 'Introduction', link: '/introduction' },
                    { text: 'Getting Started', link: '/getting-started' },
                    // ...
                ],
            },
        ],
    },
};
```

## 基础知识

侧边栏菜单最简单的形式是传入一个链接数组。第一级项目定义了侧栏的“部分”。它应该包含 `text`，这是部分的标题，和 `items`，这是实际的导航链接。

```ts
export default {
    themeConfig: {
        sidebar: [
            {
                text: 'Section Title A',
                items: [
                    { text: 'Item A', link: '/item-a' },
                    { text: 'Item B', link: '/item-b' },
                    // ...
                ],
            },
            {
                text: 'Section Title B',
                items: [
                    { text: 'Item C', link: '/item-c' },
                    { text: 'Item D', link: '/item-d' },
                    // ...
                ],
            },
        ],
    },
};
```

每个 `link` 应该指定从 /`开始的实际文件的路径。如果你在链接的末尾加上斜杠，它会显示相应目录的`index.md`。

```ts
export default {
    themeConfig: {
        sidebar: [
            {
                text: 'Guide',
                items: [
                    // This shows `/guide/index.md` page.
                    { text: 'Introduction', link: '/guide/' },
                ],
            },
        ],
    },
};
```

您可以进一步嵌套侧边栏项目，从根级别开始计算，最多可达 6 级深度。请注意，嵌套项目的深度超过 6 级将被忽略，不会显示在侧边栏上。

```ts
export default {
    themeConfig: {
        sidebar: [
            {
                text: 'Level 1',
                items: [
                    {
                        text: 'Level 2',
                        items: [
                            {
                                text: 'Level 3',
                                items: [
                                    // ...
                                ],
                            },
                        ],
                    },
                ],
            },
        ],
    },
};
```

## 多个侧边栏

您可以根据页面路径显示不同的侧边栏。例如，如本网站所示，您可能希望在 `vitepress` 中创建单独侧边栏，而 `debian` 中又是 1 个独立的侧边栏

下面展示案例：

::: code-group

```txt [结构]
// 然后，更新您的配置，为每个部分定义侧边栏。这一次，您应该传递一个对象而不是数组。
.
├─ debian/
│  ├─ index.md
│  ├─ one.md
│  └─ two.md
└─ vitepress/
   ├─ index.md
   ├─ three.md
   └─ four.md
```

```ts
// 然后，更新您的配置，为每个部分定义侧边栏。这一次，您应该传递一个对象而不是数组。
export default {
    themeConfig: {
        sidebar: {
            // 在 `/debian/` 目录下的文件，展示这个侧边栏
            '/debian/': [
                {
                    text: 'Debian',
                    items: [
                        { text: 'Index', link: '/debian/' },
                        { text: 'One', link: '/debian/one' },
                        { text: 'Two', link: '/debian/two' },
                    ],
                },
            ],

            // 在 `/vitepress/` 目录下的文件，展示这个侧边栏
            '/vitepress/': [
                {
                    text: 'VitePress',
                    items: [
                        { text: 'Index', link: '/vitepress/' },
                        { text: 'Three', link: '/vitepress/three' },
                        { text: 'Four', link: '/vitepress/four' },
                    ],
                },
            ],
        },
    },
};
```

:::

## 可折叠的边栏组

默认情况下，所有部分都是“打开”的。如果你想在初始页面加载时关闭它们，请将 `collapsed` 选项设置为 `true`。

```ts
export default {
    themeConfig: {
        sidebar: [
            {
                text: 'Section Title A',
                collapsed: true,
                items: [
                    // ...
                ],
            },
        ],
    },
};
```

## useSidebar <Badge type="info" text="可组合" />

返回与侧栏相关的数据。返回的对象具有以下类型：

::: code-group

```ts [结构]
export interface DocSidebar {
    isOpen: Ref<boolean>;
    sidebar: ComputedRef<DefaultTheme.SidebarItem[]>;
    sidebarGroups: ComputedRef<DefaultTheme.SidebarItem[]>;
    hasSidebar: ComputedRef<boolean>;
    hasAside: ComputedRef<boolean>;
    leftAside: ComputedRef<boolean>;
    isSidebarEnabled: ComputedRef<boolean>;
    open: () => void;
    close: () => void;
    toggle: () => void;
}
```

```vue [案例]
<script setup>
    import { useSidebar } from 'vitepress/theme';

    const { hasSidebar } = useSidebar();
</script>

<template>
    <div v-if="hasSidebar">Only show when sidebar exists</div>
</template>
```

:::
