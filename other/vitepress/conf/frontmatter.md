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

### 页面的标题 {#frontmatter-config-title}

- Name: `title`
- Type: `string`

它与 `config.title` 相同，它覆盖了站点级配置。

```yaml
---
title: VitePress
---
```

### 标题的后缀 {#frontmatter-config-title-template}

- Name: `titleTemplate`
- Type: `string | boolean`

它与 `config.titleTemplate` 相同，它覆盖了站点级配置。

```yaml
---
title: VitePress
titleTemplate: Vite & Vue powered static site generator
---
```

### 页面的说明 {#frontmatter-config-description}

- Name: `description`
- Type: `string`

它与 `config.description ` 相同，它覆盖了站点级配置。

```yaml
---
description: VitePress
---
```

### 额外头标记 {#frontmatter-config-head}

- Name: `head`
- Type: `HeadConfig[]`

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

### 默认主题特性

以下前言选项仅在使用默认主题时适用

#### 页面布局

- Name: `layout`
- Type: `doc | home | page`
- Default: `doc`

```yaml
---
layout: doc
---
```

| 选项   | 说明                                                                                          |
| ------ | --------------------------------------------------------------------------------------------- |
| `doc`  | 将默认文档样式应用于降价内容                                                                  |
| `home` | 主页”的特殊布局。您可以添加额外的选项，例如 `hero` 和 `features` ，以快速创建漂亮的登录页面。 |
| `page` | 类似于 `doc` ，但它不对内容应用任何样式。当您想要创建完全自定义的页面时很有用。               |

#### hero

定义当 `layout` 设置为 `home` 时 `hero` 部分的内容才有效。

```yaml
---
layout: home

hero:
  name: PHP Environment
  text: PHP 环境搭建
  tagline: 基于Debian发行版的PHP环境搭建教程
  image:
    src: '/assets/svg/php.svg'
    alt: 'PHP 环境搭建'
  actions:
    - theme: brand
      text: 环境搭建
      link: /environment/
    - theme: alt
      text: SQL
      link: /sql/common/
    - theme: alt
      text: 自述
      link: /readme
---
```

#### features

定义当 `layout` 设置为 `home` 时 `features` 部分的内容才有效。

```yaml
---
layout: home

features:
  - icon:
      light: /assets/svg/linux.svg
      dark: /assets/svg/debian.svg
    title: Debian 教程
    details: Linux发行版
    link: /debian/index
  - icon:
      src: /assets/svg/nginx.svg
    title: Nginx 教程
    details: Web服务器
    link: /nginx/index
  - icon:
      src: /assets/svg/other.svg
    title: Other
    details: 其它文档
    link: /other/index
---
```

#### aside

定义文档布局中搁置组件的位置。

说人话：设置当前文件的标题列表导航位置

- Name: `aside`
- Type: `boolean | 'left'`
- Default: `true`

| 选项     | 说明                   |
| -------- | ---------------------- |
| `false`  | 不展示标题列表导航     |
| `true`   | 标题列表导航呈现到右侧 |
| `'left'` | 标题列表导航呈现到左侧 |

#### outline

大纲中要为页面显示的页眉级别

说人话：当前文件的标题列表导航展示 `h2-h6` 中哪些级别的标题

- Name: `outline`
- Type: `number | [number, number] | 'deep' | false`
- Default: `2`

| 选项               | 说明                      |
| ------------------ | ------------------------- |
| `number`           | 没啥用                    |
| `[number, number]` | 没啥用                    |
| `'deep'`           | 列表展示 `h2-h6` 全部标题 |
| `false`            | 不展示                    |

::: tip
它与 [[config.themeConfig.outline]](https://vitepress.dev/reference/default-theme-config#outline) 相同，它覆盖了主题配置。
:::

#### 最近更新

是否在当前页面的页脚中显示 `上次更新时间` 文本：

- Name: `lastUpdated`
- Type: `boolean`
- Default: `true`

| 选项    | 说明   |
| ------- | ------ |
| `true`  | 展示   |
| `false` | 不展示 |

```yaml
---
lastUpdated: false
---
```

#### 编辑链接

是否在当前页面的页脚中显示 `编辑链接`：

- Name: `editLink`
- Type: `boolean`
- Default: `true`

| 选项    | 说明   |
| ------- | ------ |
| `true`  | 展示   |
| `false` | 不展示 |

```yaml
---
editLink: false
---
```
