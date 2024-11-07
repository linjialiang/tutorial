# 概述

Prettier 是一个有主见的代码格式化程序，原生支持：

- JavaScript
- JSX
- Angular
- Vue
- Flow
- TypeScript
- CSS, Less, SCSS
- HTML
- Ember/Handlebars
- JSON
- GraphQL
- Markdown
- YAML

以及第三方维护的其他语言扩展

## 安装

```bash
# 在本地安装Prettier
pnpm add --save-dev --save-exact prettier
# 创建一个空的配置文件，让编辑器和其他工具知道你正在使用Prettier
node --eval "fs.writeFileSync('.prettierrc','{}\n')"
# 创建一个.prettierignore文件，让Prettier CLI和编辑器知道哪些文件不需要格式化
node --eval "fs.writeFileSync('.prettierignore','# Ignore artifacts:\nbuild\ncoverage\n')"
# 使用Prettier格式化所有文件
pnpm exec prettier . --write
```

## 配置文件优先级

1. 项目根目录下 `package.<json|yaml>` 文件里的 `"prettier"` 键
2. 用 JSON 或 YAML 编写的 `.prettierrc` 文件
3. `.prettierrc.<json|yml|yaml|json5>` 文件
4. 使用 `.prettierrc.js` 或 `prettier.config.js` 导出 `export default` 或 `module.exports` 对象的文件（取决于 type 中的 package.json 值）
5. 使用 `.prettierrc.mjs` 或 `prettier.config.mjs` 导出 `export default` 对象的文件
6. 使用 `.prettierrc.cjs` 或 `prettier.config.cjs` 导出 `module.exports` 对象的文件
7. `.prettierrc.toml` 文件

## 配置覆盖

覆盖允许你针对特定扩展、文件夹以及特定文件拥有不同的配置

Prettier 参考了 ESLint 的覆盖格式

::: code-group

```json [JSON]
{
  "semi": false,
  "overrides": [
    {
      "files": "*.test.js",
      "options": {
        "semi": true
      }
    },
    {
      "files": ["*.html", "legacy/**/*.js"],
      "options": {
        "tabWidth": 4
      }
    }
  ]
}
```

```yaml [YAML]
semi: false
overrides:
  - files: "*.test.js"
    options:
      semi: true
  - files:
      - "*.html"
      - "legacy/**/*.js"
    options:
      tabWidth: 4
```

:::

## 设置解析器选项

默认情况下，Prettier 会根据输入文件的扩展名自动推断使用哪个解析器。结合 `overrides`，你可以教 Prettier 如何解析它无法识别的文件。

- 例如，要让 Prettier 格式化自己的 `.prettierrc` 文件，您可以执行以下操作：

  ```json
  {
    "overrides": [
      {
        "files": ".prettierrc",
        "options": { "parser": "json" }
      }
    ]
  }
  ```

- 您也可以切换到 `flow` 解析器，而不是默认的.js 文件的 `babel`：

  ```json
  {
    "overrides": [
      {
        "files": "*.js",
        "options": {
          "parser": "flow"
        }
      }
    ]
  }
  ```

::: warning
注意：不要将 `parser` 选项放在配置的顶层。只能在 `overrides` 里面使用。否则，将禁用 Prettier 的自动文件扩展名为基础来推理解析器的功能。

这会强制 Prettier 使用您为所有类型的文件指定的解析器--即使它没有意义，比如试图将 CSS 文件解析为 JavaScript。
:::
