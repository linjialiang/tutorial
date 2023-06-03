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

## 根目录和源目录

VitePress 项目的文件结构中有两个重要概念：项目[根目录](#root-dir)和[源目录](#source-dir)。

### 根目录 {#root-dir}

项目根目录是 VitePress 尝试查找 [[.vitepress]](#vitepress-dir) 特殊目录的地方。

从命令行运行 `vitepress dev` 或 `vitepress build` 时，VitePress 将使用当前工作目录作为项目根目录。

要将子目录指定为 root，您需要将相对路径传递给命令。

例如，

::: details 如果您的 VitePress 项目位于 ./docs 中，则应运行 vitepress dev docs ：

::: code-group

```bash [目录结构]
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

:::

### 源目录 {#source-dir}

## 附录

{#vitepress-dir}

::: tip .vitepress
.vitepress 目录是 VitePress 配置文件、开发服务器缓存、生成输出和可选主题自定义代码的默认保留位置
:::
