---
title: 搜索
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

VitePress 支持使用浏览器内索引的模糊全文搜索，这要归功于 [minisearch](https://github.com/lucaong/minisearch/)。

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

## i18n

您可以使用这样的配置来使用多语言搜索：

::: code-group

```ts [多语言]
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    search: {
      provider: "local",
      options: {
        locales: {
          zh: {
            translations: {
              button: {
                buttonText: "搜索文档",
                buttonAriaLabel: "搜索文档",
              },
              modal: {
                noResultsText: "无法找到相关结果",
                resetButtonTitle: "清除查询条件",
                footer: {
                  selectText: "选择",
                  navigateText: "切换",
                },
              },
            },
          },
        },
      },
    },
  },
});
```

```ts [仅中文]
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    search: {
      provider: "local",
      options: {
        translations: {
          button: {
            buttonText: "搜索文档",
            buttonAriaLabel: "搜索文档",
          },
          modal: {
            noResultsText: "无法找到相关结果",
            resetButtonTitle: "清除查询条件",
            footer: {
              selectText: "选择",
              navigateText: "切换",
            },
          },
        },
      },
    },
  },
});
```

:::

## miniSearch 选项

`miniSearch` 是 VitePress 自带的搜索功能，您可以像这样配置 MiniSearch：

```ts
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    search: {
      provider: "local",
      options: {
        miniSearch: {
          /**
           * @type {Pick<import('minisearch').Options, 'extractField' | 'tokenize' | 'processTerm'>}
           */
          options: {
            /* ... */
          },
          /**
           * @type {import('minisearch').SearchOptions}
           * @default
           * { fuzzy: 0.2, prefix: true, boost: { title: 4, text: 2, titles: 1 } }
           */
          searchOptions: {
            /* ... */
          },
        },
      },
    },
  },
});
```
