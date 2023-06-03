---
title: MarkDown 扩展
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

VitePress 内置了 Markdown 扩展，下面是详细介绍。

## 锚链接

VitePress 可以使用 `markdown.anchor` 选项配置定位点的呈现，支持 `标头` 和 `普通行`

-   标头：允许您链接到标题为 `#root-dir` 而不是默认的 `#项目根目录`
-   普通行：无需标头，也可以快捷设置锚链接

::: code-group

```md [标头]
...

项目[根目录](#root-dir)和[源目录](#source-dir)。

### 项目根目录 {#root-dir}

...

### 项目源目录 {#source-dir}

...
```

```md [普通行]
...

项目根目录是 VitePress 尝试查找 [[.vitepress]](#vitepress-dir) 特殊目录的地方。

...

{#vitepress-dir}

.vitepress 目录是 VitePress 配置文件、开发服务器缓存、生成输出和可选主题自定义代码的默认保留位置
```

:::

## 链接

VitePress [[内部]](#internal-links)和[[外部]](#external-links)链接都得到了特殊处理。

### 内部链接 {#internal-links}

内部链接转换为路由器链路，用于 SPA 导航(侧边导航)。此外，每个子目录中包含的每个 `index.md` 将自动转换为 `index.html` ，并带有相应的 URL `/` 。

例如，给定以下目录结构：

::: code-group

```text [目录结构]
.
├─ index.md
├─ foo
│  ├─ index.md
│  ├─ one.md
│  └─ two.md
└─ bar
   ├─ index.md
   ├─ three.md
   └─ four.md
```

```md [foo/one.md]
[Home](/) <!-- 将用户发送到 /index.md -->
[foo](/foo/) <!-- 将用户发送到 foo/index.md -->
[foo heading](./#heading) <!-- 将用户定位到 foo 目录下的文件中的首个 heading 标题 -->
[bar - three](../bar/three) <!-- 定位到 /bar/three.md 推荐写法 -->
[bar - three](../bar/three.md) <!-- 定位到 /bar/three.md 不推荐的写法 -->
[bar - four](../bar/four.html) <!-- 定位到 /bar/four.md 不推荐的写法 -->
```

:::

::: tip 页面后缀
默认情况下，页面和内部链接使用 `.html` 后缀生成。
:::

### 外部链接 {#external-links}

出站链接自动生成 `target="_blank" rel="noreferrer"`

## YAML 前置支持

YAML 前置开箱即用支持：

```yaml
---
title: Blogging Like a Hacker
lang: en-US
---
```

::: info
此数据将可用于页面的其余部分，以及所有自定义和主题组件

有关更多详细信息，请参阅配置里的[[前置配置]](../config#frontmatter-config)。
:::

## GitHub 样式表

::: details 输入

```md
| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| col 3 is      | right-aligned | $1600 |
| col 2 is      |   centered    |   $12 |
| zebra stripes |   are neat    |    $1 |
```

:::

::: details 输出

| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| col 3 is      | right-aligned | $1600 |
| col 2 is      |   centered    |   $12 |
| zebra stripes |   are neat    |    $1 |

:::

## 表情符号

::: details 输入

```md
:tada: :100:
```

:::

::: details 输出
:tada: :100:
:::

> `markdown-it-emoji` 所有 [表情符号的列表](./emoji) 都可用

## 目录
