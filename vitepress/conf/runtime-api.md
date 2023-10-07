---
title: 运行时API
titleTemplate: VitePress 教程
---

# 运行时 API

VitePress 提供了几个内置的 API，让您可以访问应用程序数据。VitePress 还附带了一些可以在全局范围内使用的内置组件。

helper 方法可以从 `vitepress` 全局导入，通常用于自定义主题 Vue 组件。然而，它们也可以在 `.md` 页面中使用，因为 markdown 文件被编译成 [[Vue 单文件组件](https://vuejs.org/guide/scaling-up/sfc.html)]。

以 `use*` 开头的方法表示它是一个 [`Vue 3 Composition API`](https://vuejs.org/guide/introduction.html#composition-api) 函数（“Composable”），只能在 `setup()`或 `<script setup>` 中使用。

## useData <Badge type="info" text="可组合" />

::: details 返回特定于页的数据。返回的对象具有以下类型：
<<<@/assets/vitepress/useData.ts

::: tip 范例：

```vue
<script setup>
import { useData } from "vitepress";

const { theme } = useData();
</script>

<template>
  <h1>{{ theme.footer.copyright }}</h1>
</template>
```

:::

## useRoute <Badge type="info" text="可组合" />

返回具有以下类型的当前路由对象：

```ts
interface Route {
  path: string;
  data: PageData;
  component: Component | null;
}
```

## useRouter <Badge type="info" text="可组合" />

返回 VitePress 路由器实例，以便您可以以编程方式导航到另一个页面。

```ts
interface Router {
  /**
   * Current route.
   */
  route: Route;
  /**
   * Navigate to a new URL.
   */
  go: (to?: string) => Promise<void>;
  /**
   * Called before the route changes. Return `false` to cancel the navigation.
   */
  onBeforeRouteChange?: (to: string) => Awaitable<void | boolean>;
  /**
   * Called before the page component is loaded (after the history state is
   * updated). Return `false` to cancel the navigation.
   */
  onBeforePageLoad?: (to: string) => Awaitable<void | boolean>;
  /**
   * Called after the route changes.
   */
  onAfterRouteChanged?: (to: string) => Awaitable<void>;
}
```

## withBase <Badge type="info" text="helper" />

- Type: `(path: string) => string`

将配置的 [`base`](./site#base) 追加到给定的 URL 路径。另见 [Base URL](./../guide/writing/resources#base-url)。

## `<Content />` <Badge type="info" text="component" />

`<Content />`组件显示渲染的 markdown 内容。[在创建自己的主题时](https://vitepress.dev/guide/custom-theme)很有用。

```vue
<template>
  <h1>Custom Layout!</h1>
  <Content />
</template>
```

## `<ClientOnly  />` <Badge type="info" text="component" />

`<ClientOnly />`组件仅在客户端呈现其槽。

由于 VitePress 应用程序在生成静态构建时是在 Node.js 中进行服务器渲染的，因此任何 Vue 的使用都必须符合通用代码要求。简而言之，确保只访问 beforeMount 或 mounted hook 中的 Browser / DOM API。

如果您正在使用或演示的组件不是 SSR 友好的（例如，包含自定义指令），您可以将它们包装在 `ClientOnly` 组件中。

```vue
<ClientOnly>
  <NonSSRFriendlyComponent />
</ClientOnly>
```

## `$frontmatter` <Badge type="info" text="模板全局" />

在 Vue 表达式中直接访问当前页面的 [frontmatter](./frontmatter) 数据。

```md
---
title: Hello
---

# {{ $frontmatter.title }}
```

## `$params` <Badge type="info" text="模板全局" />

在 Vue 表达式中直接访问当前页面的动态路由参数。

```md
- package name: {{ $params.pkg }}
- version: {{ $params.version }}
```
