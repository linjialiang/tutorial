---
title: 快速开始
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

::: details 使用前你的电脑需要满足以下条件：

1. 安装 node.js 并 >= 16
2. 支持通过其命令行界面(bash、cmd 等)访问 VitePress
3. 支持 MarkDown 语法的文本编辑器（强烈推荐 [vscode](/other/vscode/)）

:::

## 安装 {#stupe}

VitePress 可以单独使用，也可以安装到现有项目中。两者都可以使用以下命令安装它：

::: code-group

```bash [pnpm]
pnpm add -D vitepress
```

```bash [npm]
npm install -D vitepress
```

```bash [yarn]
yarn add -D vitepress
```

:::

::: tip 关于包管理器
由于 pnpm 包管理器更省磁盘资源，今后操作会尽可能多的使用 pnpm 包管理器
:::

## 向导

VitePress 附带一个命令行设置向导，可帮助您搭建基本项目的基架。

[[安装]](#stupe)后，通过运行以下命令启动向导：

```bash
pnpm exec vitepress init
```

::: details 您会看到几个简单的问题：

::: code-group

```bash [英文]
┌   Welcome to VitePress!
│
◇  Where should VitePress initialize the config?
│  ./
│
◇  Site title:
│  test Project
│
◇  Site description:
│  测试站点描述
│
◇  Theme:
│  Default Theme + Customization
│
◇  Use TypeScript for config and theme files?
│  Yes
│
◇  Add VitePress npm scripts to package.json?
│  Yes
│
└  Done! Now run npm run docs:dev and start writing.

Tips:
- Since you've chosen to customize the theme, you should also explicitly install vue as a dev dependency.
```

```bash [中文]
┌   欢迎使用 VitePress!
│
◇   VitePress应该在哪里初始化配置？
│  ./
│
◇  站点标题:
│  测试站点
│
◇  站点描述:
│  测试站点描述
│
◇  主题:
│  Default Theme + Customization
│
◇  对配置文件和主题文件使用TypeScript?
│  Yes
│
◇  将 VitePress 包添加到 npm 脚本文件 package.json?
│  Yes
│
└  完成！现在运行 npm run docs:dev 并开始编写。

Tips:
- 既然您已经选择了自定义主题，那么您还应该明确地将vue作为开发依赖项安装。
```

:::

## 安装依赖

像上面我们选择了自定义主题，就应该显示安装 vue 作为项目依赖：

```bash
pnpm add -D vue
```

## 项目结构

常见的 VitePress 项目结构有 2 种：

1. 单独使用
2. 安装到项目的 `/docs` 目录中

::: code-group

```bash [独立项目]
.
├─ .vitepress
│  └─ config.js
├─ api-examples.md
├─ markdown-examples.md
├─ index.md
└─ package.json

```

```bash [docs目录]
.
├─ docs
│  ├─ .vitepress
│  │  └─ config.js
│  ├─ api-examples.md
│  ├─ markdown-examples.md
│  └─ index.md
└─ package.json

```

:::

::: tip 提示
默认情况下，VitePress 将其开发服务器缓存存储在 `.vitepress/cache` 中，并将生产构建输出存储在 `.vitepress/dist` 中。

如果使用 Git，则应将它们添加到 `.gitignore` 文件中。

当然这些位置也可以配置。
:::

## 启动并运行

如果按上面的步骤下来， package.json 的 script 选项已经加入：

::: code-group

```json [项目根目录]
{
  ...
  "scripts": {
    "docs:dev": "vitepress dev",
    "docs:build": "vitepress build",
    "docs:preview": "vitepress preview"
  },
  ...
}
```

```json [./docs目录]
{
  ...
  "scripts": {
    "docs:dev": "vitepress dev docs",
    "docs:build": "vitepress build docs",
    "docs:preview": "vitepress preview docs"
  },
  ...
}
```

:::

::: code-group

```bash [开发环境]
# 使用 npm 脚本
pnpm docs:dev
# 直接调用 VitePress - 文档在 项目根目录
pnpm exec vitepress dev
# 直接调用 VitePress - 文档在 ./docs目录
pnpm exec vitepress dev docs
```

```bash [构建打包]
# 使用 npm 脚本
pnpm docs:build
# 直接调用 VitePress - 文档在 项目根目录
pnpm exec vitepress build
# 直接调用 VitePress - 文档在 ./docs目录
pnpm exec vitepress build docs
# 生成后，通过运行以下命令在本地预览它
pnpm docs:preview
```

:::

## 下一步

1. 要了解 markdown 文件如何映射到生成的 HTML，请继续阅读 [路由指南](/other/vitepress/route)。
2. 要了解在页面上能做什么，一个很好的起点是阅读 [MarkDown 扩展](/other/vitepress/md) 。
3. 要探索默认文档主题提供的功能，请查看 [默认主题配置参考](/other/vitepress/config#default-theme)。
4. 如果要进一步自定义网站的外观，请探索如何 [扩展默认主题](https://vitepress.dev/guide/extending-default-theme) 或 [构建自定义主题](https://vitepress.dev/guide/custom-theme)。
5. 文档站点形成后，请务必阅读 [部署指南](/other/vitepress/deploy)。
