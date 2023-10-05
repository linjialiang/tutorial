---
title: 路由
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

VitePress 使用基于文件的路由，这意味着生成的 HTML 页面是从源 Markdown 文件的目录结构映射的。

例如，给定以下目录结构对应的页面映射将是：

::: code-group

```txt [源码结构]
.
├─ guide
│  ├─ getting-started.md
│  └─ index.md
├─ index.md
└─ prologue.md
```

```txt [生成页面映射]
index.md                  -->  /index.html (accessible as /)
prologue.md               -->  /prologue.html
guide/index.md            -->  /guide/index.html (accessible as /guide/)
guide/getting-started.md  -->  /guide/getting-started.html
```

:::

::: tip
生成的 HTML 可以托管在任何可以提供静态文件的 Web 服务器上。
:::

## 根目录和源目录 {#root-and-source-dir}

VitePress 项目的文件结构中有两个重要概念：项目[根目录](#root-dir)和[源目录](#source-dir)。

### 项目根目录 {#root-dir}

项目根目录是 VitePress 尝试查找 [[.vitepress]](#vitepress-dir) 特殊目录的地方。

从命令行运行 `vitepress dev` 或 `vitepress build` 时，VitePress 将使用当前工作目录作为项目根目录。

要将子目录指定为 root，您需要将相对路径传递给命令。

::: info 例如，如果您的 VitePress 项目位于 ./docs 中，则：

::: code-group

```txt [目录结构]
.
├─ docs                    # project root
│  ├─ .vitepress           # config dir
│  ├─ getting-started.md
│  └─ index.md
└─ ...

```

```bash [运行]
pnpm exec vitepress dev docs
```

```txt [生成页面映射]
docs/index.md            -->  /index.html (accessible as /)
docs/getting-started.md  -->  /getting-started.html
```

:::

### 项目源目录 {#source-dir}

源目录是 Markdown 源文件所在的位置。默认情况下，它与项目根目录相同。

但是，您可以通过 `srcDir` 配置选项对其进行配置。srcDir 选项相对于项目根目录解析。

例如，使用 `srcDir: 'src'` ，您的文件结构将如下所示：

::: code-group

```txt [目录结构]
. # project root
├─ .vitepress # config dir
└─ src # source dir
├─ getting-started.md
└─ index.md

```

```txt [生成页面映射]
src/index.md            -->  /index.html (accessible as /)
src/getting-started.md  -->  /getting-started.html
```

:::

## 页面之间的链接

在页面之间链接时，可以同时使用绝对路径和相对路径。

::: warning 请注意
尽管 `.md` 和 `.html` 扩展名都有效，但最佳做法是省略文件扩展名，以便 VitePress 可以根据您的配置生成最终 URL。

```bash
<!-- 推荐 -->
[Getting Started](./getting-started)
[Getting Started](../guide/getting-started)

<!-- 不推荐 -->
[Getting Started](./getting-started.md)
[Getting Started](./getting-started.html)
```

:::

## 更多

VitePress 路由功能不止这些，部分内容会涉及到 Vue3，具体请阅读 [[官方手册]](https://vitepress.dev/guide/routing)

## 附录

{#vitepress-dir}

::: tip .vitepress
`.vitepress` 目录是 VitePress 配置文件、开发服务器缓存、生成输出和可选主题自定义代码的默认保留位置
:::
