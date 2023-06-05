---
title: 设置
titleTemplate: vscode 教程
---

# {{ $frontmatter.title }}

用户可以修改的设置主要有 3 种级别：

1. 用户级别设置
   - 本地用户设置
   - 远程用户设置(需安装远程插件)
2. 工作区级别设置

## 快捷方式

- 快捷键：`Ctrl+.`
- 命令行: `Ctrl+Shift+P` > 搜索 `settings`

## 用户设置

用户设置的配置文件存放在路径

- Windows: `C:\Users\Administrator\AppData\Roaming\Code\User\settings.json`
- Linux: `待补充`
- 远程用户设置(Linux): `~/.vscode-server/data/Machine/settings.json`

::: details 设置示例
<<< @/assets/vscode/settings.json
:::

## 工作区设置

路径：`{{项目根目录}}/.vscode/settings.json`

## prettier 配置文件

prettier 配置文件格式有多种，按优先级顺序如下：

1. 在 `package.json` 里的 `prettier` 选项中增加配置

2. 使用 `.prettierrc` 文件，格式可以使用 `JSON`、`YAML` 语法

3. 使用特定语言格式：

   - json 语法：`.prettierrc.json`
   - yaml 语法：`.prettierrc.yaml`

4. 使用 js 语言格式：

   `.prettierrc.js`、 `prettier.config.js` `prettier.config.cjs`、 `.prettierrc.cjs`

5. 使用 `.prettierrc.toml` 文件

6. 使用 `.editorconfig` 文件

::: warning 需要注意
prettier 无法识别 ES6 模块导入语法

配置文件 `.editorconfig` 使用的是 `EditorConfig` 语法规则
:::

::: details 示例：
<<< @/assets/vscode/.prettierrc.js
:::

## prettier 忽略配置文件

prettier 忽略配置文件名 `.prettierignore`

```
package.json
pnpm-lock.yaml
.vitepress/dist/
.vitepress/cache/
.vitepress/.temp/
```
