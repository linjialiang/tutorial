---
title: 搜索
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

VitePress 支持使用浏览器内索引的模糊全文搜索，这要归功于 `minisearch`。

要启用此功能，只需在 `.vitepress/config.ts` 文件中将 `themeConfig.search.provider` 选项设置为 `'local'`：

```ts
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    search: {
      provider: "local",
    },
  },
});
```

或者，您可以使用 [Algolia DocSearch](https://vitepress.dev/reference/default-theme-search#algolia-search) 或一些社区插件，如 https://www.npmjs.com/package/vitepress-plugin-search 或 https://www.npmjs.com/package/vitepress-plugin-pagefind 。
