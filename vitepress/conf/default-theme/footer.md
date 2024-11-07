---
title: 页脚
titleTemplate: VitePress 教程
---

# 页脚

当设置了 `themeConfig.footer` 时，VitePress 将在页面底部显示全局页脚。

::: code-group

```ts [案例]
export default {
    themeConfig: {
        footer: {
            message: '程序员系列教程',
            copyright: 'Copyright © 2023-present linjialiang',
        },
    },
};
```

```ts [结构]
export interface Footer {
    // 在 版权说明 之前的文本消息
    message?: string;

    // 实际版权文本说明
    copyright?: string;
}
```

:::

上述配置还支持 `HTML` 字符串。因此，例如，如果您想将页脚文本配置为具有一些链接，可以如下调整配置：

```ts
export default {
    themeConfig: {
        footer: {
            message:
                'Released under the <a href="https://github.com/vuejs/vitepress/blob/main/LICENSE">MIT License</a>.',
            copyright: 'Copyright © 2019-present <a href="https://github.com/yyx990803">Evan You</a>',
        },
    },
};
```

::: warning 警告
只有 `内联元素` 可以在 `footer.message` 和 `footer.copyright` 中使用，因为它们在`<p>`元素中呈现。如果您想添加块元素，请考虑使用 [`layout-bottom`](https://vitepress.dev/guide/extending-default-theme#layout-slots) 替代
:::

## Frontmatter 配置

这可以在每个页面的前言配置上使用的 `footer` 选项禁用：

```yaml
---
footer: false
---
```
