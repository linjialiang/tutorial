# 选项

## 换行长度（非强制）

指定打印机将换行的行长度

| Default | CLI 参数              | API 参数            |
| ------- | --------------------- | ------------------- |
| `80`    | `--print-width <int>` | `printWidth: <int>` |

## 缩进长度

指定每个缩进级别的空格数

| Default | CLI 参数            | API 参数          |
| ------- | ------------------- | ----------------- |
| `2`     | `--tab-width <int>` | `tabWidth: <int>` |

## 缩进类型

使用制表符而不是空格缩进

| Default | CLI 参数     | API 参数          |
| ------- | ------------ | ----------------- |
| `false` | `--use-tabs` | `useTabs: <bool>` |

## 分号

在陈述式的结尾增加分号

-   `true`: 每个语句的末尾添加`;`
-   `false`: 仅在可能导致 ASI 故障的行的开头添加 `;`

| Default | CLI 参数    | API 参数       |
| ------- | ----------- | -------------- |
| `true`  | `--no-semi` | `semi: <bool>` |

## 使用单引号

使用单引号而不是双引号

-   JSX 引号会忽略此选项
-   如果引号的数量超过其他引号，则较少使用的引号将用于格式化字符串，例如：
    1. `"I'm double quoted"` 结果是 `"I'm double quoted"`
    2. `"This \"example\" is single quoted"` 结果是 `'This "example" is single quoted'`

| Default | CLI 参数         | API 参数              |
| ------- | ---------------- | --------------------- |
| `false` | `--single-quote` | `singleQuote: <bool>` |

## 属性中的引号

更改对象中的属性的引号，有效选项：

-   `"as-needed"` 仅在需要时在对象属性周围添加引号
-   `"consistent"` 如果对象中至少有一个属性需要引号，则将所有属性都引号化
-   `"preserve"` 尊重对象属性中引号的输入使用

new

| Default        | CLI 参数                                          | API 参数                                           |
| -------------- | ------------------------------------------------- | -------------------------------------------------- |
| `"consistent"` | `--quote-props <as-needed\|consistent\|preserve>` | `quoteProps: "<as-neededa\|consistent\|preserve>"` |

## JSX 中使用单引号

在 JSX 中使用单引号而不是双引号

| Default | CLI 参数             | API 参数                 |
| ------- | -------------------- | ------------------------ |
| `false` | `--jsx-single-quote` | `jsxSingleQuote: <bool>` |

## 尾随逗号

在多行逗号分隔的语法结构中，尽可能打印尾随逗号（注意：单行数组永远不会有尾随逗号），有效选项：

-   `"all"` 尽可能使用尾随逗号
-   `"es5"` 在 ES 5 中有效的尾随逗号（对象，数组等）。TypeScript 和 Flow 中类型参数的尾随逗号
-   `"none"` 没有尾随逗号

| Default | CLI 参数                            | API 参数                            |
| ------- | ----------------------------------- | ----------------------------------- |
| `"all"` | `--trailing-comma <all\|es5\|none>` | `trailingComma: "<all\|es5\|none>"` |

## 括号间距

打印对象文字中括号之间的空格，有效选项：

-   `true` 带空格，示例：`{ foo: bar }`
-   `false` 不带空格，示例：`{foo: bar}`

| Default | CLI 参数               | API 参数                 |
| ------- | ---------------------- | ------------------------ |
| `true`  | `--no-bracket-spacing` | `bracketSpacing: <bool>` |

## 标签线

将多行 HTML（HTML，JSX，Vue，Angular）元素的 `>` 放在最后一行的末尾，而不是单独放在下一行（不适用于自关闭元素）。有效选项：

-   `true` 示例：

    ```text
    <button
      className="prettier-class"
      id="prettier-id"
      onClick="{this.handleClick}">
      Click Here
    </button>
    ```

-   `false` 示例：

    ```text
    <button
    className="prettier-class"
    id="prettier-id"
    onClick="{this.handleClick}"
    >
    Click Here
    </button>
    ```

| Default | CLI 参数              | API 参数                  |
| ------- | --------------------- | ------------------------- |
| `false` | `--bracket-same-line` | `bracketSameLine: <bool>` |

## 箭头功能括号

在唯一的箭头函数参数周围包括圆括号，有效选项：

-   `"always"` -始终包含括号。示例：`(x) => x`
-   `"avoid"` -尽可能省略括号。示例：`x => x`

| Default    | CLI 参数                         | API 参数                         |
| ---------- | -------------------------------- | -------------------------------- |
| `"always"` | `--arrow-parens <always\|avoid>` | `arrowParens: "<always\|avoid>"` |

## 选中格式化范围

这两个选项可用于格式化以给定字符偏移量开始和结束的代码（分别为包含和排除）。范围将扩大：

-   返回到包含所选语句的第一行的开头
-   前进到所选语句的结尾

| Default    | CLI 参数              | API 参数            |
| ---------- | --------------------- | ------------------- |
| `0`        | `--range-start <int>` | `rangeStart: <int>` |
| `Infinity` | `--range-end <int>`   | `rangeEnd: <int>`   |

## 解析器

Prettier 自动从输入文件路径推断格式化的解析器，因此您不必更改此设置

| Default | CLI 参数            | API 参数             |
| ------- | ------------------- | -------------------- |
| `None`  | `--parser <string>` | `parser: "<string>"` |

## 文件路径

指定用于推断要使用哪个分析器的文件名

例如，下面将使用 CSS 解析器：

```bash
cat foo | prettier --stdin-filepath foo.css
```

| Default | CLI 参数                    | API 参数               |
| ------- | --------------------------- | ---------------------- |
| `None`  | `--stdin-filepath <string>` | `filepath: "<string>"` |

## 指定文件要格式化

Prettier 可以将自己限制为，只有在文件顶部包含特殊注释（称为 pragma）的文件，才支持格式化。这在逐渐将大型的、未格式化的代码库转换为 Prettier 时非常有用。

当提供 `--require-pragma` 选项时，仅针对首个注释使用如下注释内容的文件进行格式化：

```js
/**
 * @prettier
 */
```

或者

```js
/**
 * @format
 */
```

| Default | CLI 参数           | API 参数                |
| ------- | ------------------ | ----------------------- |
| `false` | `--require-pragma	` | `requirePragma: <bool>` |

## 格式化文件时插入备注

Prettier 可以在文件的顶部插入一个特殊的 `@format` 标记，指定该文件已被 Prettier 格式化。

这在与--require-pragma 选项一起使用时效果很好。

如果在文件的顶部已经有一个 docblock，那么这个选项将添加一个带有 `@format` 标记的新行。

请注意：`--require-pragma` 优先级高于 `--insert-pragma`，如果同时使用 `--insert-pragma` 将会被忽略

| Default | CLI 参数          | API 参数               |
| ------- | ----------------- | ---------------------- |
| `false` | `--insert-pragma` | `insertPragma: <bool>` |

## 强制换行

有效选项：

-   `"always"` 如果散文超过打印宽度，则将其换行
-   `"never"` 将每个散文块展开为一行
-   `"preserve"` 什么都不做，让散文保持原样。

| Default    | CLI 参数                                 | API 参数                                 |
| ---------- | ---------------------------------------- | ---------------------------------------- |
| `preserve` | `--prose-wrap <always\|never\|preserve>` | `proseWrap: "<always\|never\|preserve>"` |

## HTML 空白敏感度

为 HTML、Vue、Angular 和 Handlebars 指定全局空格敏感性。有效选项：

-   `"css"` 尊重 CSS `display`属性的默认值。对于手柄，处理方式与 `strict` 相同
-   `"strict"` 所有标签周围的空白（或缺少空白）被认为是重要的
-   `"ignore"` 所有标签周围的空白（或缺少空白）被认为是无关紧要的

| Default | CLI 参数                                              | API 参数                                             |
| ------- | ----------------------------------------------------- | ---------------------------------------------------- |
| `"css"` | `--html-whitespace-sensitivity <css\|strict\|ignore>` | `htmlWhitespaceSensitivity: "<css\|strict\|ignore>"` |

## Vue 文件脚本和样式标签缩进

是否对 Vue 文件的 `<script>` 和 `<style>` 标签中的内容进行缩进，有效选项：

-   `false` 不要在 Vue 文件中缩进脚本和样式标签里的内容
-   `true` 在 Vue 文件中缩进脚本和样式标签里的内容

| Default | CLI 参数                        | API 参数                          |
| ------- | ------------------------------- | --------------------------------- |
| `false` | `--vue-indent-script-and-style` | `vueIndentScriptAndStyle: <bool>` |

## 行尾

有效选项：

-   `"lf"` 只有换行 `\n`
-   `"crlf"` 回车+换行 `\r\n`
-   `"cr"` 回车 `\r`
-   `"auto"` 维护现有的行结束符（通过查看第一行之后使用的内容来规范化一个文件中的混合值）

| Default | CLI 参数                             | API 参数                            |
| ------- | ------------------------------------ | ----------------------------------- |
| `"lf"`  | `--end-of-line <lf\|crlf\|cr\|auto>` | `endOfLine: "<lf\|crlf\|cr\|auto>"` |

## 嵌入式语言格式

控制 Prettier 是否格式化文件中嵌入的引用代码

当 Prettier 识别出它看起来像是你在另一个文件中放置了一些代码时，它知道如何在字符串中格式化，比如：

-   在 JavaScript 中带有标签名为 html 的标记模板中，
-   在 Markdown 中的代码块中，它会默认尝试格式化该代码。

有效选项：

-   `"auto"` 如果 Prettier 可以自动识别，则格式化嵌入代码
-   `"off"` 永远不要自动格式化嵌入式代码

| Default  | CLI 参数                                     | API 参数                                    |
| -------- | -------------------------------------------- | ------------------------------------------- |
| `"auto"` | `--embedded-language-formatting=<off\|auto>` | `embeddedLanguageFormatting: "<off\|auto>"` |

## 每行单个属性

在 HTML、Vue 和 JSX 中强制每行使用一个属性，有效选项：

-   `false` 不要强制每行使用单个属性
-   `true` 每行强制执行单个属性

| Default | CLI 参数                      | API 参数                         |
| ------- | ----------------------------- | -------------------------------- |
| `false` | `--single-attribute-per-line` | `singleAttributePerLine: <bool>` |
