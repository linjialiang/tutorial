---
title: Nav
titleTemplate: VitePress 教程
---

# Nav

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

## 导航链接

您可以定义 `themeConfig.nav` 选项来添加链接到您的导航。

```ts
export default {
  themeConfig: {
    nav: [
      { text: "Guide", link: "/guide" },
      { text: "Config", link: "/config" },
      { text: "Changelog", link: "https://github.com/..." },
    ],
  },
};
```

`text` 是导航中显示的实际文本，`link` 是单击文本时将导航到的链接。对于链接，请将路径设置为不带.md 前缀的实际文件，并始终以/开头。

导航链接也可以是下拉菜单。要执行此操作，请在链接选项上设置 items 键。

```ts
export default {
  themeConfig: {
    nav: [
      { text: "Guide", link: "/guide" },
      {
        text: "Dropdown Menu",
        items: [
          { text: "Item A", link: "/item-1" },
          { text: "Item B", link: "/item-2" },
          { text: "Item C", link: "/item-3" },
        ],
      },
    ],
  },
};
```

请注意，下拉菜单标题（上面示例中的 `Dropdown Menu`）不能具有 `link` 属性，因为它将成为打开下拉对话框的按钮。

您还可以通过传入更多的嵌套项来进一步向下拉菜单项添加“部分”。

```ts
export default {
  themeConfig: {
    nav: [
      { text: "Guide", link: "/guide" },
      {
        text: "Dropdown Menu",
        items: [
          {
            // Title for the section.
            text: "Section A Title",
            items: [
              { text: "Section A Item A", link: "..." },
              { text: "Section B Item B", link: "..." },
            ],
          },
        ],
      },
      {
        text: "Dropdown Menu",
        items: [
          {
            // You may also omit the title.
            items: [
              { text: "Section A Item A", link: "..." },
              { text: "Section B Item B", link: "..." },
            ],
          },
        ],
      },
    ],
  },
};
```

## 自定义链接的 active 状态

默认情况下：当前页面位于匹配路径下时，对应导航菜单项将突出显示。

如果你想自定义匹配的路径，定义 `activeMatch` 属性和正则表达式作为字符串值。

```ts
export default {
  themeConfig: {
    nav: [
      // This link gets active state when the user is
      // on `/config/` path.
      {
        text: "Guide",
        link: "/guide",
        activeMatch: "/config/",
      },
    ],
  },
};
```

::: warning
`activeMatch` 应该是一个正则表达式字符串，但你必须将其定义为字符串。

我们不能在这里使用实际的 `RegExp` 对象，因为它在构建时是不可序列化的。
:::

## 自定义链接的 `target` 和 `rel` 属性

默认情况下，VitePress 会根据链接是否为外部链接自动判断 `target` 和 `rel` 属性。但是如果你愿意，你也可以定制它们。

```ts
export default {
  themeConfig: {
    nav: [
      {
        text: "Merchandise",
        link: "https://www.thegithubshop.com/",
        target: "_self",
        rel: "sponsored",
      },
    ],
  },
};
```

## 联系我们

参考 [socialLinks](./overview#sociallinks)
