---
title: Edit Link
titleTemplate: VitePress 教程
---

# Edit Link

编辑链接允许您在 Git 管理服务（如 `GitHub` 或 `Gitee`）上显示一个链接来编辑页面。要启用它，请在配置中添加 `themeConfig.editLink` 选项。

```ts
export default {
  themeConfig: {
    editLink: {
      pattern: "https://github.com/linjialiang/php-environment/edit/main/:path",
    },
  },
};
```

`pattern` 选项定义链接的 URL 结构，而 `:path` 将被替换为页面路径。

你也可以使用一个纯函数，它接受 `PageData` 作为参数并返回 URL 字符串。

```ts
export default {
  themeConfig: {
    editLink: {
      pattern: ({ filePath }) => {
        if (filePath.startsWith("packages/")) {
          return `https://github.com/acme/monorepo/edit/main/${filePath}`;
        } else {
          return `https://github.com/acme/monorepo/edit/main/docs/${filePath}`;
        }
      },
    },
  },
};
```

它不应该有副作用，也不应该访问其范围之外的任何内容，因为它将在浏览器中序列化和执行。

默认情况下，这将在文档页面的底部添加链接文本“编辑此页面”。您可以通过定义 text 选项来自定义此文本。

```ts
export default {
  themeConfig: {
    editLink: {
      pattern: "https://github.com/vuejs/vitepress/edit/main/docs/:path",
      text: "Edit this page on GitHub",
    },
  },
};
```

## Frontmatter 配置

这可以使用 `frontmatter` 上的 `editLink` 选项在每个页面上禁用：

```yaml
---
editLink: false
---
```
