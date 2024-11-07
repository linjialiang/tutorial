---
title: 布局
titleTemplate: VitePress 教程
---

# 布局

您可以通过 md 文件前言的 `layout` 参数来选择页面布局。有 3 个布局选项，`doc`、`page` 和 `home`。如果未指定任何内容，则该页面将被视为 `doc` 页面。

```yaml
---
layout: doc
---
```

## Doc 布局

选项 `doc` 是默认布局，它将整个 Markdown 内容样式化为 `文档` 外观。它的工作原理是将整个内容包装在 `vp-doc` css 类中，并将样式应用到它下面的元素。

几乎所有的通用元素，如 `p` 或 `h2` 都有特殊的样式。因此，请记住，如果您在 Markdown 内容中添加任何自定义 HTML，它们也会受到这些样式的影响。

```yaml
---
layout: doc
---
```

文档布局还提供下面列出的文档特定功能。

1. Edit 链接
2. 上一页 和 下一页
3. 大纲
4. [广告位](https://vitepress.dev/reference/default-theme-carbon-ads)

::: tip 提示
这些功能仅在此布局中启用。
:::

## Page 布局

选项 `page` 被视为“空白页”。Markdown 仍然会被解析，所有的 Markdown 扩展都和 `doc` 布局一样工作，但是它不会得到任何默认的样式。

页面布局将让您的风格一切由你没有 VitePress 主题影响标记。这在您想要创建自己的自定义页面时非常有用。

```yaml
---
layout: page
---
```

::: warning 请注意：
即使在这种布局中，如果页面有匹配的侧边栏配置，侧边栏仍然会显示。
:::

## Home 布局

选项 `home` 将生成模板化的“主页”。在此布局中，您可以设置额外的选项，例如 `hero` 和 `features`，以进一步自定义内容。请访问[默认主题：主页](./home)了解更多详情。

```yaml
---
layout: home
---
```

## 没有布局

如果你不想要任何布局，你可以通过 `frontmatter` 传递 `layout: false`。如果您想要一个完全可自定义的登录页面（默认情况下没有任何侧边栏、导航栏或页脚），此选项将非常有用。

```yaml
---
layout: false
---
```

## 自定义布局

您也可以使用自定义布局：

```yaml
---
layout: foo
---
```

这将查找在上下文中注册的名为 `foo` 的组件。例如，您可以在 `.vitepress/theme/index.ts` 中全局注册组件：

```ts
import DefaultTheme from 'vitepress/theme';
import Foo from './Foo.vue';

export default {
    extends: DefaultTheme,
    enhanceApp({ app }) {
        app.component('foo', Foo);
    },
};
```
