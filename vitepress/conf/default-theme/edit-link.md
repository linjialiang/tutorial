---
title: Edit Link
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

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
