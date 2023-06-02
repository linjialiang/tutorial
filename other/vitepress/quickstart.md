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

::: code-group

```bash [pnpm]
pnpm exec vitepress init
```

:::

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

::: code-group

```bash [pnpm]
pnpm add -D vue
```

:::
