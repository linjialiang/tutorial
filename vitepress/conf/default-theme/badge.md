---
title: 徽章
titleTemplate: VitePress 教程
outline: 2
---

# 徽章

您可以使用徽章向标题添加状态。例如，指定节的类型或支持的版本可能很有用。

## 使用

您可以使用全局可用的 `Badge` 组件。

```md
### Title <Badge type="info" text="default" />

### Title <Badge type="tip" text="^1.9.0" />

### Title <Badge type="warning" text="beta" />

### Title <Badge type="danger" text="caution" />
```

::: details 上面的代码呈现如下：

### Title <Badge type="info" text="default" />

### Title <Badge type="tip" text="^1.9.0" />

### Title <Badge type="warning" text="beta" />

### Title <Badge type="danger" text="caution" />

:::

## 自定义子节点

`<Badge>` 接受子节点，它将显示在徽章中。

```md
### Title <Badge type="info">custom element</Badge>

### Title <Badge type="info" text="text属性失效">custom element</Badge>

### Title <Badge type="info"><span style="color:red">custom element</span></Badge>
```

::: details 上面的代码呈现如下：

### Title <Badge type="info">custom element</Badge>

### Title <Badge type="info" text="text属性失效">custom element</Badge>

### Title <Badge type="info"><span style="color:red">custom element</span></Badge>

:::

## 自定义类型颜色

您可以通过覆盖 css 变量来自定义徽章的样式。以下是默认值：

```css
:root {
    --vp-badge-info-border: transparent;
    --vp-badge-info-text: var(--vp-c-text-2);
    --vp-badge-info-bg: var(--vp-c-default-soft);

    --vp-badge-tip-border: transparent;
    --vp-badge-tip-text: var(--vp-c-brand-1);
    --vp-badge-tip-bg: var(--vp-c-brand-soft);

    --vp-badge-warning-border: transparent;
    --vp-badge-warning-text: var(--vp-c-warning-1);
    --vp-badge-warning-bg: var(--vp-c-warning-soft);

    --vp-badge-danger-border: transparent;
    --vp-badge-danger-text: var(--vp-c-danger-1);
    --vp-badge-danger-bg: var(--vp-c-danger-soft);
}
```

## `<Badge>`

`<Badge>` 组件接受以下道具：

```ts
interface Props {
    // 当传递 `<slot>` 时, text将被忽略
    // <slot> 应该是 <Badge> 的子节点
    text?: string;

    // 有4种类型，默认是 tip
    type?: 'info' | 'tip' | 'warning' | 'danger';
}
```
