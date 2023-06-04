---
title: 配置
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

本篇讲解 VitePress 常见配置

## 站点配置

站点配置是可以定义站点的全局设置的位置。

应用程序配置选项定义适用于每个 VitePress 站点的设置，无论它使用什么主题。

例如，网站的基目录或标题。

### 配置文件

配置文件始终从 `<root>/.vitepress/config.[ext]` 解析，其中 `<root>` 是你的 VitePress 项目根目录，`[ext]` 是受支持的文件扩展名之一。

TypeScript 是开箱即用的。支持的扩展包括 `.js`、`.ts`、`.cjs`、`.mjs`、`.cts` 和 `.mts` 。

::: details 建议在配置文件中使用 ES 模块语法。配置文件应默认导出一个对象：

```ts
export default {
    // app level config options
    lang: 'zh-CN',
    title: 'PHP Environment',
    description: '基于Debian的php环境搭建教程',
    ...
}
```

:::

### 配置智能感知

使用 `defineConfig` 帮助程序将为配置选项提供 TypeScript 驱动的智能感知。

假设您的 IDE 支持它，这应该在 `JavaScript` 和 `TypeScript` 中都有效。

```ts
import { defineConfig } from 'vitepress';

export default defineConfig({
    // ...
});
```

### 类型化主题配置

默认情况下， `defineConfig` 帮助程序需要默认主题的主题配置类型：

```ts
import { defineConfig } from 'vitepress';

export default defineConfig({
    themeConfig: {
        // Type is `DefaultTheme.Config`
    },
});
```

如果使用自定义主题并希望对主题配置进行类型检查，则需要改用 `defineConfigWithTheme` ，并通过泛型参数传递自定义主题的配置类型：

```ts
import { defineConfigWithTheme } from 'vitepress';
import type { ThemeConfig } from 'your-theme';

export default defineConfigWithTheme<ThemeConfig>({
    themeConfig: {
        // Type is `ThemeConfig`
    },
});
```

### Vite, Vue & Markdown Config

-   Vite

    您可以使用 VitePress 配置中的 [[vite 选项]](#vite) 配置底层 Vite 实例。

    无需创建单独的 Vite 配置文件。

-   Vue

    VitePress 已经包含了 Vite 的官方 Vue 插件 （ [@vitejs/plugin-vue](https://github.com/vitejs/vite-plugin-vue) ）。

    您可以使用 VitePress 配置中的 vue 选项配置其选项。

-   Markdown

    您可以使用 VitePress 配置中的 [[markdown 选项]](#makrdown) 配置底层 [Markdown-It](https://github.com/markdown-it/markdown-it) 实例。

## 默认主题 {#default-theme}

## 前置配置 {#frontmatter-config}

## Markdown 选项 {#markdown}

```

```
