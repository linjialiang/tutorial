---
title: 站点配置
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

站点配置是可以定义站点的全局设置的位置。

应用程序配置选项定义适用于每个 VitePress 站点的设置，无论它使用什么主题。

例如，网站的基目录或标题。

## 总览

### 配置文件

配置文件始终从 `<root>/.vitepress/config.[ext]` 解析，其中 `<root>` 是你的 VitePress 项目根目录，`[ext]` 是受支持的文件扩展名之一。

TypeScript 是开箱即用的。支持的扩展包括 `.js`、`.ts`、`.cjs`、`.mjs`、`.cts` 和 `.mts` 。

::: details 建议在配置文件中使用 ES 模块语法。配置文件应默认导出一个对象：

```ts
export default {
  // app level config options
  lang: "zh-CN",
  title: "Tutorial",
  description: "程序员系列教程",
  // ...
};
```

:::

### 配置智能感知

使用 `defineConfig` helper 程序将为配置选项提供基于 TypeScript 的智能感知。

如果您的 IDE 支持它，在 `JavaScript` 和 `TypeScript` 中应该都有效。

```ts
import { defineConfig } from "vitepress";

export default defineConfig({
  // ...
});
```

### 类型化主题配置

默认情况下， `defineConfig` help 程序需要默认主题的主题配置类型：

```ts
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    // Type is `DefaultTheme.Config`
  },
});
```

如果使用自定义主题并希望对主题配置进行类型检查，则需要改用 `defineConfigWithTheme` ，并通过泛型参数传递自定义主题的配置类型：

```ts
import { defineConfigWithTheme } from "vitepress";
import type { ThemeConfig } from "your-theme";

export default defineConfigWithTheme<ThemeConfig>({
  themeConfig: {
    // Type is `ThemeConfig`
  },
});
```

### Vite, Vue & Markdown Config

- Vite

  您可以使用 VitePress 配置中的 [[vite 选项]](https://vitejs.dev/config/) 配置底层 Vite 实例。

  无需创建单独的 Vite 配置文件。

- Vue

  VitePress 已经包含了 Vite 的官方 Vue 插件 （ [@vitejs/plugin-vue](https://github.com/vitejs/vite-plugin-vue) ）。

  您可以使用 VitePress 配置中的 vue 选项配置其选项。

- Markdown

  您可以使用 VitePress 配置中的 [[markdown 选项]](#markdown) 配置底层 [Markdown-It](https://github.com/markdown-it/markdown-it) 实例。

## 站点元数据

### 网站标题 {#title}

- Name: `title`
- Type: `string`
- Default: `VitePress`
- 可以通过每页的[[前言配置]](#frontmatter-config-title)覆盖

使用默认主题时，这将显示在导航栏中。

它还将用作所有单个页面标题的默认后缀，除非定义了 `titleTemplate` 。单个页面的最终标题将是其第一个 `<h1>` 标题的文本内容，并结合全局 `title` 作为后缀。

例如：使用以下配置和页面内容，页面的标题将为 `Hello | My Awesome Site`

::: code-group

```ts [config.ts]
export default {
  title: "My Awesome Site",
};
```

```md [doc文件]
# Hello
```

:::

### 标题后缀模板

- Name: `titleTemplate`
- Type: `string | boolean`
- 可以通过每页的[[前言配置]](#frontmatter-config-title-template)覆盖

允许自定义每个页面的 `标题后缀` 或 `整个标题` 。

例如：使用以下配置和页面内容，页面的标题将为 `Hello | Custom Suffix` 。

::: code-group

```ts [config.ts]
export default {
  title: "My Awesome Site",
  titleTemplate: "Custom Suffix",
};
```

```md [doc文件]
# Hello
```

:::

#### 完全自定义标题

若要完全自定义标题的呈现方式，可以在 `titleTemplate` 中使用 `:title` 符号：

::: code-group

```ts [config.ts]
export default {
  titleTemplate: ":title - Custom Suffix",
};
```

```md [doc文件]
# Hello
```

:::

此处 `:title `将替换为从页面的第一个 `<h1>` 标题推断的文本。

示例页面的标题将是 `Hello - Custom Suffix` 。

#### 禁用标题后缀

可以将该选项设置为 `false` 以禁用标题后缀：

```ts
export default {
  titleTemplate: false,
};
```

### 网站说明

- Name: `description`
- Type: `string`
- Default: `A VitePress site`
- 可以通过每页的[[前言配置]](#frontmatter-config-description)覆盖

这将在页面 HTML 中呈现为 `<meta>` 标记

```ts
export default {
  description: "A VitePress site",
};
```

### 头部

- Name: `head`
- Type: `string`
- Default: `[]`
- 可以通过每页的[[前言配置]](#frontmatter-config-head)追加

::: warning 注意
`head` 通过前言配置(frontmatter)是 `追加` 而不是 `覆盖`
:::

要在页面 HTML 的 `<head>` 标记中呈现的其他元素。

用户添加的标记在结束 `head` 标记之前呈现，在 VitePress 标记之后呈现。

::: code-group

```ts [config.ts]
export default {
  head: [
    [
      "link",
      { rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "" },
    ],
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    [
      "script",
      { id: "register-sw" },
      `;(() => {
        if ('serviceWorker' in navigator) {
          navigator.serviceWorker.register('/sw.js')
        }
      })()`,
    ],
  ],
};

// 渲染后:
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link rel="icon" href="/favicon.ico">
<script id="register-sw">
  ;(() => {
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.register('/sw.js')
    }
  })()
</script>
```

```ts [HeadConfig 类型]
type HeadConfig =
  | [string, Record<string, string>]
  | [string, Record<string, string>, string];
```

:::

### 网址 lang 属性

- Name: `lang`
- Type: `string`
- Default: `en-US`

这将在页面 HTML 中呈现为 `<html lang="en-US">` 标记

```ts
// 中文
export default {
  lang: "zh-CN",
};
```

### 部署站点的基本 URL {#base}

- Name: `base`
- Type: `string`
- Default: `/`

如果您计划在子路径（例如 GitHub 页面）下部署站点，则需要设置此设置。

如果计划将站点部署到 `https://foo.github.io/bar/` ，则应将 `base` 设置为 `'/bar/'` 。它应始终以斜杠开头和结尾。

::: code-group

```ts [部署到根目录]
export default {
  base: "/",
};
```

```ts [部署到base目录]
export default {
  base: "/base/",
};
```

```ts [部署到doc目录]
export default {
  base: "/doc/",
};
```

:::

## 路由

### cleanUrls

- Name: `cleanUrls`
- Type: `boolean`
- Default: `false`

当设置为 `true` 时，VitePress 将从 URL 中删除尾随的 `.html` 。另请参阅[[生成干净的 URL]](https://vitepress.dev/guide/routing#generating-clean-url)。

::: warning 需要服务器支持
启用此功能可能需要在您的托管平台上进行其他配置。

为了使它工作，你的服务器必须能够在访问 `/foo` 时提供 `/foo.html` 而不需要重定向。
:::

### 重写

- Name: `rewrites`
- Type: `Record<string, string>`
- Default: 没有默认值

定义自定义 `目录<->URL` 的映射。有关详细信息，请参阅[[路由：路由重写]](https://vitepress.dev/guide/routing#route-rewrites)。

```ts
export default {
  rewrites: {
    "source/:page": "destination/:page",
  },
};
```

## 构建

### 源目录

- Name: `srcDir`
- Type: `string`
- Default: `.`

存储 markdown 页面的目录（相对于项目根目录）。

```ts
export default {
  srcDir: "./src",
};
```

### 排除文件

- Name: `srcExclude`
- Type: `string`
- Default: `undefined`

用于匹配应作为源内容排除的 Markdown 文件的 glob 模式。

说人话：开发、构建时不编译这些 Markdown 文件。

```ts
export default {
  srcExclude: ["**/README.md", "**/TODO.md"],
};
```

### 输出目录

- Name: `outDir`
- Type: `string`
- Default: `./.vitepress/dist`

站点相对于项目根目录的生成输出位置，相对于 `./.vitepress` 目录。

```ts
export default {
  outDir: "../public",
};
```

### 资源目录

- Name: `assetsDir`
- Type: `string`
- Default: `assets`

资源文件的目录。另请参见：[[资源目录]](https://vitejs.dev/config/build-options.html#build-assetsdir)。

```ts
export default {
  assetsDir: "static",
};
```

### 缓存目录

- Name: `cacheDir`
- Type: `string`
- Default: `./.vitepress/cache`

缓存文件的目录，相对于 [项目根目录](/other/vitepress/route#root-dir) 。

```ts
export default {
  cacheDir: "./.vitepress/.vite",
};
```

更多内容请参阅： [Vite 缓存目录](https://vitejs.dev/config/shared-options.html#cachedir) 。

### 忽略死链接验证

- Name: `ignoreDeadLinks`
- Type: `boolean | 'localhostLinks' | (string | RegExp | ((link: string) => boolean))[]`
- Default: `false`

当设置为 `true` 时，VitePress 不会因为死链接而使构建失败。

设置为 `'localhostLinks'` 时，构建将在死链接上失败，但不会检查 localhost 链接。

```ts
export default {
  ignoreDeadLinks: true,
};
```

::: details 也可以是准确的 url 字符串、正则表达式模式或自定义过滤器函数的数组

```ts
export default {
  ignoreDeadLinks: [
    // ignore exact url "/playground"
    "/playground",
    // ignore all localhost links
    /^https?:\/\/localhost/,
    // ignore all links include "/repl/""
    /\/repl\//,
    // custom function, ignore all links include "ignore"
    (url) => {
      return url.toLowerCase().includes("ignore");
    },
  ],
};
```

:::

### mpa <Badge type="warning" text="实验" />

vitepress 默认采用 `spa` 模式构建成单页面，使用 js 控制。

而启用 `mpa` 模式是构建成多页面，不需要 js 控制，对搜索引擎 SEO 优化可能更友好，具体请 [[阅读官网]](https://vitepress.dev/reference/site-config#mpa)

## 主题

### 是否启用深色模式

- Name: `appearance`
- Type: `boolean | 'dark' | 'force-dark' | import('@vueuse/core').UseDarkOptions`
- Default: `true`

通过在 `＜html＞` 元素上添加 `.dark` 类来实现是否启用暗模式。

```ts
export default { appearance: true };
```

如果该选项设置为 `true` ，则默认主题将由用户的首选配色方案确定。

如果该选项设置为 `dark` ，则默认情况下主题将为深色，除非用户手动切换它。

如果该选项设置为 `false` ，用户将无法切换主题。

::: tip 此选项注入一个内联脚本
该脚本使用 `vitepress-theme-appearance` 键从本地存储还原用户设置。这可确保在呈现页面之前应用 `.dark` 类以避免闪烁。

`appearance.initialValue` 只能是 `'dark' | undefined` ，不支持引用或 getter。
:::

### 是否启用最新更新

- Name: `lastUpdated`
- Type: `boolean`
- Default: `false`

是否使用 Git 获取每个页面的上次更新时间戳。时间戳将包含在每个页面的页面数据中，可通过 `useData` 访问。

```ts
export default defineConfig({ lastUpdated: true });
```

::: details 使用默认主题时

启用此选项将显示每个页面的上次更新时间。

您可以通过 `themeConfig.lastUpdatedText` 选项自定义文本。

```ts
export default defineConfig({
  lastUpdated: true,
  themeConfig: { lastUpdatedText: "最近更新" },
});
```

:::

## 定制

### Markdown 选项 {#markdown}

- Type: `MarkdownOption`

VitePress 使用 Markdown-it 作为解析器，使用 Shiki 来突出显示语言语法。

在此选项中，您可以传递各种与 Markdown 相关的选项以满足您的需求。

::: code-group

```ts [写法]
export default {
  markdown: {
    // ...
  },
};
```

```ts [禁用行数]
export default {
  markdown: { lineNumbers: false },
};
```

:::

::: details 以下是您可以在此对象中使用的所有选项：
<<<@/assets/vitepress/MarkdownOptions.ts
:::

### vite

- Type: `import('vite').UserConfig`

将原始 [`Vite Config`](https://vitejs.dev/config/) 传递到内部 Vite dev 服务器/捆绑包。

```ts
export default {
  vite: {
    // Vite config options
  },
};
```

### vue

- Type: `import('@vitejs/plugin-vue').Options`

将原始 [`@vitejs/plugin-vue`选项](https://github.com/vitejs/vite-plugin-vue/tree/main/packages/plugin-vue#options)传递给内部插件实例。

```ts
export default {
  vue: {
    // @vitejs/plugin-vue options
  },
};
```

## 构建挂钩

这部分内容请查看 [[官方手册]](https://vitepress.dev/reference/site-config#build-hooks)
