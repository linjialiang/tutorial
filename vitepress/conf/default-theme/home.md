---
title: 主页
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

VitePress 默认主题提供了一个主页布局，你也可以看到在这个网站的主页上使用。您可以在任何页面上使用它，只需在 `frontmatter` 中指定 `layout: home`。

```yaml
---
layout: home
---
```

不过，光靠这一条路，恐怕也没什么用。您可以通过设置其他选项（如 `hero` 和 `features`）向主页添加几个不同的预模板区块。

## Hero 区块

Hero 区块是对项目的整体定义

Hero 区块位于主页的顶部。下面介绍如何配置 `Hero` 部分。

::: code-group

```yaml [案例]
---
layout: home

hero:
  name: VitePress
  text: Vite & Vue powered static site generator.
  tagline: Lorem ipsum...
  image:
    src: /logo.png
    alt: VitePress
  actions:
    - theme: brand
      text: Get Started
      link: /guide/what-is-vitepress
    - theme: alt
      text: View on GitHub
      link: https://github.com/vuejs/vitepress
---
```

```ts [结构]
// Hero 区块接口
interface Hero {
  // 显示在 text 上方的字符串。文字附带渐变颜色，建议简短，如：产品名称。
  name?: string;

  // Hero区块的正文。这将被定义为“h1”标记。
  text: string;

  // Tagline 在 text 下方显示
  tagline?: string;

  // 电脑端 name|text|tagline|actions在左边，图片在右边
  // 手机端则在 name 的上方
  image?: ThemeableImage;

  // hero 区块显示的按钮
  actions?: HeroAction[];
}

type ThemeableImage =
  | string
  | { src: string; alt?: string }
  | { light: string; dark: string; alt?: string };

// actions 接口
interface HeroAction {
  // 按钮的颜色主题，默认是 brand
  theme?: "brand" | "alt";

  // 按钮的标签文字
  text: string;

  // 按钮的目标链接，支持vitepress内部连接和外部连接
  link: string;
}
```

:::

### 自定义名称颜色

VitePress 使用（`--vp-c-brand-1`）作为 `name` 的渐变颜色。但是，您可以通过覆盖 `--vp-home-hero-name-color` 变量来自定义此颜色。

```css
/* .vitepress/theme/style.css */
:root {
  --vp-home-hero-name-color: blue;
}
```

您也可以通过组合 `--vp-home-hero-name-background` 来进一步自定义它，以给予 `name` 渐变色。

```css
/* .vitepress/theme/style.css */
:root {
  --vp-home-hero-name-color: transparent;
  --vp-home-hero-name-background: -webkit-linear-gradient(
    120deg,
    #bd34fe,
    #41d1ff
  );
}
```

## Features 区块

Features 区块是用于展示当前站点功能模块列表的

在 Features 区块，你可以列出任何数量的功能模块，显示在 Hero 区块后面。要配置它，请将 `features` 选项传递给 `frontmatter`。

您可以为每个功能模块提供一个图标，可以是表情符号或任何类型的图像。

当配置的图标是图像（`svg`，`png`，`jpeg`...）时您必须提供具有适当宽度和高度的图标;您还可以提供描述，其固有的大小以及它的变种为黑暗和光明的主题时，需要的。

::: code-group

```yaml [案例]
---
layout: home

features:
  - icon: 🛠️
    title: Simple and minimal, always
    details: Lorem ipsum...
  - icon:
      src: /cool-feature-icon.svg
    title: Another cool feature
    details: Lorem ipsum...
  - icon:
      dark: /dark-feature-icon.svg
      light: /light-feature-icon.svg
    title: Another cool feature
    details: Lorem ipsum...
---
```

```ts [结构]
interface Feature {
  // 在每个功能框上显示图标。
  icon?: FeatureIcon;

  // 功能模块标题
  title: string;

  // 功能模块的细节描述
  details: string;

  // 单击组件时的链接。链接可以是内部的，也可以是外部的。如：
  // 内部：`guid/reference/default-theme-home-page`
  // 外部：`htttps://example.com`
  link?: string;

  // 主要对连接做个提示，界面效果是：一段文本 + 右箭头（→）
  //
  // 如：`- linkText: 点击进入学习`
  linkText?: string;

  // a标签上的 rel 属性
  //
  // 如：连接上有广告，就应该加上 `- rel: sponsored`
  rel?: string;
}

type FeatureIcon =
  | string
  | { src: string; alt?: string; width?: string; height: string }
  | {
      light: string;
      dark: string;
      alt?: string;
      width?: string;
      height: string;
    };
```
