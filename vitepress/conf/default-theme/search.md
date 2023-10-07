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

VitePress 支持 `miniSearch` 搜索功能，您可以像这样配置 MiniSearch：

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

## 自定义内容呈现器

您可以自定义用于在索引之前呈现 markdown 内容的函数：

```ts
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    search: {
      provider: "local",
      options: {
        /**
         * @param {string} src
         * @param {import('vitepress').MarkdownEnv} env
         * @param {import('markdown-it')} md
         */
        _render(src, env, md) {
          // return html string
        },
      },
    },
  },
});
```

此函数将从客户端站点数据中剥离，因此您可以在其中使用 Node.js API。

::: details 示例：从搜索中排除页面

```ts
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    search: {
      provider: "local",
      options: {
        _render(src, env, md) {
          const html = md.render(src, env);
          if (env.frontmatter?.search === false) return "";
          if (env.relativePath.startsWith("some/path")) return "";
          return html;
        },
      },
    },
  },
});
```

::: warning 注意
如果提供了自定义的 `_render` 函数，您需要在前言(frontmatter)自己处理 `search: false` 。

此外，在调用 `md.render` 之前， `env` 对象不会被完全填充，因此`env` 对象任何可选的属性（如：frontmatter）的检查，都应该在调用之后进行。
:::

::: details 示例：转换内容-添加锚点

```ts
import { defineConfig } from "vitepress";

export default defineConfig({
  themeConfig: {
    search: {
      provider: "local",
      options: {
        _render(src, env, md) {
          const html = md.render(src, env);
          if (env.frontmatter?.title)
            return md.render(`# ${env.frontmatter.title}`) + html;
          return html;
        },
      },
    },
  },
});
```

:::

## Algolia 搜索

Algolia 相关内容请阅读 [官方文档](https://vitepress.dev/reference/default-theme-search#algolia-search)

## 使用 vitepress-plugin-pagefind 插件

::: code-group

```bash [安装依赖]
pnpm add vitepress-plugin-pagefind pagefind -D
```

```ts [引入插件]
import { defineConfig } from "vitepress";
import { pagefindPlugin } from "vitepress-plugin-pagefind";
// https://vitepress.dev/reference/site-config
export default defineConfig({
  vite: {
    plugins: [pagefindPlugin()],
  },
});
```

```ts [中文搜索优化]
import { defineConfig } from "vitepress";
import {
  chineseSearchOptimize,
  pagefindPlugin,
} from "vitepress-plugin-pagefind";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  lang: "zh-CN",
  vite: {
    plugins: [
      pagefindPlugin({
        customSearchQuery: chineseSearchOptimize,
      }),
    ],
  },
});
```

:::

### 高级用法
