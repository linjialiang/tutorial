---
title: Nav
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

`Nav`是显示在页面顶部的导航栏。它包含网站标题、全局菜单链接等。

## 网站标题和徽标

网站标题和徽标指的是网站左上角的 `图标+文字`

默认情况下，nav 显示引用 [config.title](./../site#title) 值的站点的标题。如果你想改变导航上显示的内容，你可以在 `themeConfig.siteTitle` 选项中定义自定义文本。

```ts
export default {
  themeConfig: {
    siteTitle: "My Custom Title",
  },
};
```

如果您有站点的徽标，则可以通过传递图像的路径来显示它。您应该直接将徽标放置在 `public` 中，并定义它的绝对路径。

```ts
export default {
  themeConfig: {
    logo: "/my-logo.svg",
  },
};
```

添加徽标时，它会与网站标题沿着显示。如果您的徽标是您所需要的全部，并且如果您想隐藏网站标题文本，请将 `siteTitle` 选项设置为 `false` 。

说人话：只需要图标，不要文字

```ts
export default {
  themeConfig: {
    logo: "/my-logo.svg",
    siteTitle: false,
  },
};
```

如果要添加 alt 属性或基于暗/亮模式自定义，也可以将对象作为徽标传递。详情请参阅 [`themeConfig.logo`](./overview#logo)
