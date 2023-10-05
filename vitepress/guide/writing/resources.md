---
title: 资源处理
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

所有 Markdown 文件都被编译成 Vue 组件并由 Vite 处理。

您可以，也应该使用相对 URL 引用任何资源：

```md
![An image](./image.png)
```

你可以引用 markdown 文件中的静态资源，主题中的 `*.vue` 组件，样式和普通 `.css` 文件，可以使用绝对公共路径（基于项目根目录）或相对路径（基于文件系统）。

后者类似于您使用 Vite，Vue CLI 或 webpack 的 `file-loader` 的行为。

自动检测常见图像、媒体和字体文件类型并将其作为资源包括在内。

所有引用的资产，包括那些使用绝对路径的资产，都将在生产构建中以散列文件名复制到输出目录中。不会复制从未引用的资产。小于 4kb 的图像资源将内联 base64 -这可以通过 `vite` 配置选项进行配置。

所有静态路径引用，包括绝对路径，都应该基于您的工作目录结构。

## 公共目录

有时候，你可能需要提供没有在任何 Markdown 或主题组件中直接引用的静态资源，或者你可能希望使用原始文件名提供某些文件。这样的文件的示例包括 `robots.txt`、favicons 和 PWA 图标。

您可以将这些文件放在[[源目录]](./../introduction/route#source-dir)下的 `public` 目录中。例如，如果您的项目根目录是`./docs`，并使用默认的源目录位置，那么您的公共目录将是`./docs/public`。

放置在 `public` 中的资产将按原样复制到输出目录的根目录中。

请注意，您应该使用根绝对路径引用放置在 `public` 中的文件-例如，`public/icon.png` 应该始终在源代码中引用为 `/icon.png`

## 基本 URL

如果您的站点部署到非根 URL，则需要在 base 中设置.vitepress/config.js 选项。例如，如果您计划将您的站点部署到https://foo.github.io/bar/，那么base应该设置为'/bar/'（它应该始终以斜线开始和结束）。

所有静态资产路径都会自动处理，以适应不同的 base 配置值。例如，如果你在 markdown 中有对 public 下的资产的绝对引用：

```md
![An image](/image-inside-public.png)
```

在上面这种情况下，当您更改 base 配置值时，您不需要更新它。

但是，如果您正在创作一个动态链接到资源的主题组件，例如 src 基于主题配置值的图像：

```vue
<img :src="theme.logoPath" />
```

在这种情况下，建议使用 VitePress 提供的 [`withBase`](https://vitepress.dev/reference/runtime-api#withbase) [helper](https://vitepress.dev/reference/runtime-api#withbase) 包装路径：

```vue
<script setup>
import { withBase, useData } from "vitepress";

const { theme } = useData();
</script>

<template>
  <img :src="withBase(theme.logoPath)" />
</template>
```
