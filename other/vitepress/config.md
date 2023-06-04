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

### 总览

#### 配置文件

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

#### 配置智能感知

使用 `defineConfig` 帮助程序将为配置选项提供 TypeScript 驱动的智能感知。

假设您的 IDE 支持它，这应该在 `JavaScript` 和 `TypeScript` 中都有效。

```ts
import { defineConfig } from 'vitepress';

export default defineConfig({
    // ...
});
```

#### 类型化主题配置

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

#### Vite, Vue & Markdown Config

-   Vite

    您可以使用 VitePress 配置中的 [[vite 选项]](#vite) 配置底层 Vite 实例。

    无需创建单独的 Vite 配置文件。

-   Vue

    VitePress 已经包含了 Vite 的官方 Vue 插件 （ [@vitejs/plugin-vue](https://github.com/vitejs/vite-plugin-vue) ）。

    您可以使用 VitePress 配置中的 vue 选项配置其选项。

-   Markdown

    您可以使用 VitePress 配置中的 [[markdown 选项]](#makrdown) 配置底层 [Markdown-It](https://github.com/markdown-it/markdown-it) 实例。

### 站点元数据

#### 网站标题

-   Name: `title`
-   Type: `string`
-   Default: `VitePress`
-   可以通过每页的[[前置配置]](#frontmatter-config-title)覆盖

使用默认主题时，这将显示在导航栏中。

它还将用作所有单个页面标题的默认后缀，除非定义了 `titleTemplate` 。单个页面的最终标题将是其第一个 `<h1>` 标题的文本内容，并结合全局 `title` 作为后缀。

例如：使用以下配置和页面内容，页面的标题将为 `Hello | My Awesome Site`

::: code-group

```ts [config.ts]
export default {
    title: 'My Awesome Site',
};
```

```md [doc文件]
# Hello
```

:::

#### 标题后缀

-   Name: `titleTemplate`
-   Type: `string | boolean`
-   可以通过每页的[[前置配置]](#frontmatter-config-title-template)覆盖

允许自定义每个页面的 `标题后缀` 或 `整个标题` 。

例如：使用以下配置和页面内容，页面的标题将为 `Hello | Custom Suffix` 。

::: code-group

```ts [config.ts]
export default {
    title: 'My Awesome Site',
    titleTemplate: 'Custom Suffix',
};
```

```md [doc文件]
# Hello
```

:::

##### 完全自定义标题

若要完全自定义标题的呈现方式，可以在 `titleTemplate` 中使用 `:title` 符号：

::: code-group

```ts [config.ts]
export default {
    titleTemplate: ':title - Custom Suffix',
};
```

```md [doc文件]
# Hello
```

:::

此处 `:title `将替换为从页面的第一个 `<h1>` 标题推断的文本。

示例页面的标题将是 `Hello - Custom Suffix` 。

##### 禁用标题后缀

可以将该选项设置为 `false` 以禁用标题后缀：

```ts
export default {
    titleTemplate: false,
};
```

#### 网站说明

-   Name: `description`
-   Type: `string`
-   Default: `A VitePress site`
-   可以通过每页的[[前置配置]](#frontmatter-config-description)覆盖

这将在页面 HTML 中呈现为 `<meta>` 标记

```ts
export default {
    description: 'A VitePress site',
};
```

#### 头部

-   Name: `head`
-   Type: `string`
-   Default: `[]`
-   可以通过每页的[[前置配置]](#frontmatter-config-head)追加

::: warning 注意
`head` 通过前置配置是 `追加` 而不是 `覆盖`
:::

要在页面 HTML 的 `<head>` 标记中呈现的其他元素。

用户添加的标记在结束 `head` 标记之前呈现，在 VitePress 标记之后呈现。

::: code-group

```ts [config.ts]
export default {
    head: [
        [
            'link',
            { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
            // would render:
            //
            // <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        ],

        [
            'script',
            { id: 'register-sw' },
            `;(() => {
        if ('serviceWorker' in navigator) {
          navigator.serviceWorker.register('/sw.js')
        }
      })()`,
            // would render:
            //
            // <script id="register-sw">
            // ;(() => {
            //   if ('serviceWorker' in navigator) {
            //     navigator.serviceWorker.register('/sw.js')
            //   }
            // })()
            // </script>
        ],
    ],
};
```

```ts [HeadConfig 类型]
type HeadConfig = [string, Record<string, string>] | [string, Record<string, string>, string];
```

:::

#### 网址 lang 属性

-   Name: `lang`
-   Type: `string`
-   Default: `en-US`

这将在页面 HTML 中呈现为 `<html lang="en-US">` 标记

```ts
export default {
    lang: 'en-US',
};
```

#### 部署站点的基本 URL

-   Name: `base`
-   Type: `string`
-   Default: `/`

如果您计划在子路径（例如 GitHub 页面）下部署站点，则需要设置此设置。

如果计划将站点部署到 `https://foo.github.io/bar/` ，则应将 `base` 设置为 `'/bar/'` 。它应始终以斜杠开头和结尾。

```ts
export default {
    base: '/base/',
};
```

### 构建

#### 源目录

-   Name: `srcDir`
-   Type: `string`
-   Default: `.`

存储 markdown 页面的目录（相对于项目根目录）。

```ts
export default {
    srcDir: './src',
};
```

#### 排除文件

-   Name: `srcExclude`
-   Type: `string`
-   Default: `undefined`

用于匹配应作为源内容排除的 Markdown 文件的 glob 模式。

说人话：开发、构建时不编译这些 Markdown 文件。

```ts
export default {
    srcExclude: ['**/README.md', '**/TODO.md'],
};
```

## 默认主题 {#default-theme}

## 前置配置 {#frontmatter-config}

## Markdown 选项 {#markdown}

```

```
