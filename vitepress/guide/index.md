---
title: 什么是 VitePress ？
titleTemplate: VitePress 教程
---

# 什么是 VitePress ？

VitePress 是一个静态网站生成器（[SSG](#SSG)），旨在构建快速，以内容为中心的网站。

简单地说，VitePress 获取您用 Markdown 编写的源内容，对其应用主题，并生成可以轻松部署在任何地方的静态 HTML 页面。

[[点此进入]](https://vitepress.dev/) VitePress 官网

## 用例

### 文件

VitePress 附带了一个为技术文档设计的默认主题。它为您现在正在阅读的页面提供了支持，沿着 Vite，Rollup，Pinia，VueUse，Vitest，D3，UnoCSS，Iconify 等文档。

官方 Vue.js 文档也基于 VitePress，但使用了多个翻译之间共享的自定义主题。

### 博客、投资组合和营销网站

VitePress 支持完全自定义的主题，具有标准 Vite + Vue 应用程序的开发人员体验。构建在 Vite 上也意味着您可以直接利用 Vite 插件从其丰富的生态系统。此外，VitePress 提供灵活的 API 来加载数据（本地或远程）并动态生成路由。您可以使用它来构建几乎任何东西，只要数据可以在构建时确定。

Vue.js 官方博客是一个简单的博客，它根据本地内容生成索引页面。

## 开发者体验

VitePress 的目标是在处理 Markdown 内容时提供出色的开发者体验（DX）。

- Vite-Powered：即时服务器启动，编辑总是即时反映（100 ms），无需重新加载页面。

- 内置 Markdown 扩展：Frontmatter，表格，语法高亮显示...随便你说。具体来说，VitePress 提供了许多用于处理代码块的高级功能，使其成为高度技术性文档的理想选择。

- Vue-Enhanced Markdown：由于 Vue 模板与 HTML 的 100%语法兼容性，每个 Markdown 页面也是一个 Vue 单文件组件。您可以使用 Vue 模板特性或导入的 Vue 组件在静态内容中嵌入交互性。

## 性能

与许多传统的 SSG 不同，VitePress 生成的网站实际上是一个单页应用程序（SPA）。

### 快速初始加载

任何页面的初始访问将提供静态的，预渲染的 HTML，以获得极快的加载速度和最佳的 SEO。然后，页面加载一个 JavaScript 包，将页面转换为 Vue SPA（“水合”）。水合过程非常快：在 PageSpeed Insights 上，典型的 VitePress 网站即使在网络较慢的低端移动的设备上也能获得近乎完美的性能分数。

### 快速加载后导航

更重要的是，SPA 模型在初始加载后带来了更好的用户体验。网站内的后续导航将不再导致整个页面重新加载。相反，传入页面的内容将被获取并动态更新。VitePress 还自动预取视口内链接的页面块。在大多数情况下，后加载导航会感觉即时。

### 无惩罚的互动

为了能够融合静态 Markdown 中嵌入的动态 Vue 部分，每个 Markdown 页面都被处理为 Vue 组件并编译成 JavaScript。这听起来可能效率很低，但 Vue 编译器足够聪明，可以将静态和动态部分分开，从而最大限度地减少水合成本和有效负载大小。对于初始页面加载，静态部分将自动从 JavaScript 有效负载中消除，并在水合期间跳过。

{#SSG}

::: tip 什么是 SSG ？
SSG 代表静态站点生成器。

SSG 是一种在 CDN（内容交付网络）上生成完整静态 HTML 网站的工具。

在 SSG 中，HTML 是在构建时生成的。
:::

::: danger 文档完整性说明
该 VitePress 教程并不完善，像 `Vite` 和 `Vue3` 关联较多的知识在文档里都没有体现，更多内容请阅读 [[官方手册]](https://vitepress.dev)
:::
