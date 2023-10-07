---
title: Last Updated
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

md 文件最后一次更新内容的时间将显示在页面的右下角。要启用它，请在配置中添加 `lastUpdated` 选项。

::: tip
lastUpdated 依赖于项目的版本控制工具，您需要提交 md 文件，才能查看最后更新时间

作者使用 git 作为版本控制工具来管理项目
:::

## 全局配置

```ts
export default {
  lastUpdated: true,
};
```

## 前言配置

这可以使用 `frontmatter` 上的 `lastUpdated` 选项在每个页面上禁用：

```yaml
---
lastUpdated: false
---
```

另请参阅[默认主题：最后更新](./overview#lastupdated)以了解更多详细信息。主题级别的任何 truthy 值也将启用该功能，除非在站点或页面级别显式禁用。
