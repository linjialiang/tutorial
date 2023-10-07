---
title: frontmatter
titleTemplate: VitePress 教程
---

# frontmatter

frontmatter 是文件最上方以 `---` 分隔的区域，用于指定个别文件的变量

VitePress 在所有 Markdown 文件都支持 YAML 格式的 frontmatter，并使用灰色物质解析它们。

frontmatter 必须位于 Markdown 文件的顶部（在包括 `<script>` 标签的任何元素之前），并且必须在 `三虚线` 之间采用有效的 YAML 集的形式。范例：

```md
---
title: Docs with VitePress
editLink: true
---
```

许多站点或默认主题配置选项在 frontmatter 中都有相应的选项。您可以使用 frontmatter 仅覆盖当前页的特定行为。有关详细信息，请参阅 [Frontmatter 配置参考](https://vitepress.dev/reference/frontmatter-config)。

您还可以定义自己的自定义 frontmatter 数据，用于页面上的动态 Vue 表达式。

## 访问 Frontmatter 数据

Frontmatter 数据可以通过特殊的 `$frontmatter` 全局变量访问：

下面是一个如何在 Markdown 文件中使用它的示例：

```md
---
title: Docs with VitePress
editLink: true
---

# {{ $frontmatter.title }}

Guide content
```

您还可以使用 [`<script setup>`](https://vitepress.dev/reference/runtime-api#usedata) helper 在 `useData()` 中访问当前页面的 frontmatter 数据。

## Frontmatter 替代格式

VitePress 还支持 JSON frontmatter 语法，以花括号开头和结尾：

```json
---
{
  "title": "Blogging Like a Hacker",
  "editLink": true
}
---
```
