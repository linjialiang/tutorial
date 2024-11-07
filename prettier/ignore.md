# 忽略代码

-   使用 `.prettierignore` 完全忽略（即不重新格式化）某些文件和文件夹
-   使用 `prettier-ignore` 注释来忽略文件里的部分代码块

## 完全忽略

要排除部分文件格式化，请在项目的根目录中创建一个 `.prettierignore` 文件，并使用 `gitignore` 语法，范例：

```ini
# 忽略指定名称的文件或目录:
build
coverage

# 忽略全部html扩展的文件:
**/*.html
```

默认情况下，prettier 会忽略版本控制系统目录（`.git`、`.sl`、`.svn`和 `.hg`）和 `node_modules` 中的文件（除非指定了 `--with-node-modules` CLI 选项）。

Prettier 还将遵循 `.gitignore` 文件中指定的规则，如果它存在于运行它的同一目录中（除非指定了 `--ignore-path` CLI 选项）。

## 在文件中忽略部分代码块

在文件中通过使用 `prettier-ignore` 注释，可以对注释行，下一个代码块忽略格式化，具体案例如下：

### 1. JavaScript

::: code-group

```text [source]
matrix(
1, 0, 0,
0, 1, 0,
0, 0, 1
)

// prettier-ignore
matrix(
1, 0, 0,
0, 1, 0,
0, 0, 1
)
```

```js [结果]
matrix(1, 0, 0, 0, 1, 0, 0, 0, 1);

// prettier-ignore
matrix(
1, 0, 0,
0, 1, 0,
0, 0, 1
)
```

:::

::: code-group

```jsx [JSX]
<div>
    {/* prettier-ignore */}
    <span     ugly  format=''   />
</div>
```

```html [HTML]
<!-- prettier-ignore -->
<div         class="x"       >hello world</div            >

<!-- prettier-ignore -->
<div
  (mousedown)="       onStart    (    )         "
  (mouseup)="         onEnd      (    )         "
></div>

<!-- prettier-ignore -->
<div
  (mousedown)="onStart()"
  (mouseup)="         onEnd      (    )         "
></div>
```

```css [CSS]
/* prettier-ignore */
.my    ugly rule
{

}
```

```md [Markdown]
<!-- prettier-ignore -->
Do   not    format   this
```

:::

### JSX

### HTML

::: code-group

```text [source]

```

```html [结果]
<!-- prettier-ignore -->
<div         class="x"       >hello world</div            >

<!-- prettier-ignore-attribute -->
<div (mousedown)="       onStart    (    )         " (mouseup)="         onEnd      (    )         "></div>

<!-- prettier-ignore-attribute (mouseup) -->
<div (mousedown)="onStart()" (mouseup)="         onEnd      (    )         "></div>
```

:::
