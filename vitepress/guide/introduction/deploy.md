---
title: 部署 VitePress 网站
titleTemplate: VitePress 教程
---

# 部署 VitePress 网站

部署 VitePress 的详细内容请阅读 [[官方手册]](https://vitepress.dev/guide/deploy)

## GitHub Pages

1. 在项目的 `.github/workflows` 目录中创建一个名为 `deploy.yml` 的文件，其中包含如下内容：

<<<@/assets/vitepress/deploy.yml

::: tip
确保 VitePress 中的 `base` 选项已正确配置。有关更多详细信息，请参见[设置公共基路径](https://vitepress.dev/guide/deploy#setting-a-public-base-path)。
:::

2. 在“Pages”菜单项下的存储库设置中，选择“Build and deployment Source”中的“GitHub Actions”。

3. 将您的更改推送到 `main` 分支，并等待 `GitHub Actions` 工作流完成。您应该看到您的站点部署到 `https://<username>.github.io/[repository]/`或 `https://<custom-domain>/`，具体取决于您的设置。您的网站将在每次推送到 `main` 分支时自动部署。
