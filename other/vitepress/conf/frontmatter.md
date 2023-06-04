前言配置支持基于页面的配置。

在每个 markdown 文件中，您可以使用前言配置来覆盖站点级或主题级配置选项。

此外，还有一些只能在前言中定义的配置选项。

::: info 示例：

```md
---
title: Docs with VitePress
editLink: true
---
```

您可以通过 Vue 表达式中的 $frontmatter 全局访问前言数据：

```md
{{ $frontmatter.title }}
```

:::

### 页面的标题

-   Name: `title`
-   Type: `string`

它与 `config.title` 相同，它覆盖了站点级配置。

```yaml
---
title: VitePress
---
```

### 标题的后缀

-   Name: `titleTemplate`
-   Type: `string | boolean`

它与 `config.titleTemplate` 相同，它覆盖了站点级配置。

```yaml
---
title: VitePress
titleTemplate: Vite & Vue powered static site generator
---
```

### 页面的说明

-   Name: `description`
-   Type: `string`

它与 `config.description ` 相同，它覆盖了站点级配置。

```yaml
---
description: VitePress
---
```

### 额外头标记

-   Name: `head`
-   Type: `HeadConfig[]`

将在站点级配置注入的头标记之后追加

::: code-group

```yaml [迁移]
---
head:
    - - meta
      - name: description
        content: hello
    - - meta
      - name: keywords
        content: super duper SEO
---
```

```ts [HeadConfig 结构]
type HeadConfig = [string, Record<string, string>] | [string, Record<string, string>, string];
```

:::
