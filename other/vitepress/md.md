---
title: MarkDown 扩展
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

VitePress 内置了 Markdown 扩展，下面是详细介绍。

## 锚链接

VitePress 可以使用 `markdown.anchor` 选项配置定位点的呈现，支持 `标头` 和 `普通行`

-   标头：允许您链接到标题为 `#root-dir` 而不是默认的 `#项目根目录`
-   普通行：无需标头，也可以快捷设置锚链接

::: code-group

```md [标头]
...

项目[根目录](#root-dir)和[源目录](#source-dir)。

### 项目根目录 {#root-dir}

...

### 项目源目录 {#source-dir}

...
```

```md [普通行]
...

项目根目录是 VitePress 尝试查找 [[.vitepress]](#vitepress-dir) 特殊目录的地方。

...

{#vitepress-dir}

.vitepress 目录是 VitePress 配置文件、开发服务器缓存、生成输出和可选主题自定义代码的默认保留位置
```

:::

## 链接

VitePress [[内部]](#internal-links)和[[外部]](#external-links)链接都得到了特殊处理。

### 内部链接 {#internal-links}

内部链接转换为路由器链路，用于 SPA 导航(侧边导航)。此外，每个子目录中包含的每个 `index.md` 将自动转换为 `index.html` ，并带有相应的 URL `/` 。

例如，给定以下目录结构：

::: code-group

```txt [目录结构]
.
├─ index.md
├─ foo
│  ├─ index.md
│  ├─ one.md
│  └─ two.md
└─ bar
   ├─ index.md
   ├─ three.md
   └─ four.md
```

```md [foo/one.md]
[Home](/) <!-- 将用户发送到 /index.md -->
[foo](/foo/) <!-- 将用户发送到 foo/index.md -->
[foo heading](./#heading) <!-- 将用户定位到 foo 目录下的文件中的首个 heading 标题 -->
[bar - three](../bar/three) <!-- 定位到 /bar/three.md 推荐写法 -->
[bar - three](../bar/three.md) <!-- 定位到 /bar/three.md 不推荐的写法 -->
[bar - four](../bar/four.html) <!-- 定位到 /bar/four.md 不推荐的写法 -->
```

:::

::: tip 页面后缀
默认情况下，页面和内部链接使用 `.html` 后缀生成。
:::

### 外部链接 {#external-links}

出站链接自动生成 `target="_blank" rel="noreferrer"`

## YAML 前置支持

YAML 前置开箱即用支持：

```yaml
---
title: Blogging Like a Hacker
lang: en-US
---
```

::: info
此数据将可用于页面的其余部分，以及所有自定义和主题组件

有关更多详细信息，请参阅配置里的[[前置配置]](../config#frontmatter-config)。
:::

## GitHub 样式表

::: details 输入

```md
| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| col 3 is      | right-aligned | $1600 |
| col 2 is      |   centered    |   $12 |
| zebra stripes |   are neat    |    $1 |
```

:::

::: details 输出

| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| col 3 is      | right-aligned | $1600 |
| col 2 is      |   centered    |   $12 |
| zebra stripes |   are neat    |    $1 |

:::

## 表情符号

::: details 输入

```md
:tada: :100:
```

:::

::: details 输出
:tada: :100:
:::

> `markdown-it-emoji` 所有 [表情符号的列表](./emoji) 都可用

## 目录

可以使用 `markdown.toc` 选项配置目录的呈现。

输入：

```md
[[toc]]
```

输出：

[[toc]]

## 自定义容器

自定义容器可以按其类型、标题和内容进行定义。

### 默认标题

输入：

```md
::: info
This is an info box.
:::

::: tip
This is a tip.
:::

::: warning
This is a warning.
:::

::: danger
This is a dangerous warning.
:::

::: details
This is a details block.
:::
```

输出：

::: info
This is an info box.
:::

::: tip
This is a tip.
:::

::: warning
This is a warning.
:::

::: danger
This is a dangerous warning.
:::

::: details
This is a details block.
:::

### 自定义标题

您可以通过在容器的“类型”之后附加文本来设置自定义标题。

输入：

````md
::: danger 停止
危险区域，请勿继续
:::

::: details 单击查看代码

```js
console.log('Hello, VitePress!');
```

:::
````

输出：

::: danger 停止
危险区域，请勿继续
:::

::: details 单击查看代码

```js
console.log('Hello, VitePress!');
```

:::

## 代码块中的语法突出显示

简称：语法高亮

VitePress 使用 Shiki 在 Markdown 代码块中突出显示语言语法，使用彩色文本。Shiki 支持多种编程语言。

您需要做的就是将有效的语言别名附加到代码块的开头反引号：

::: code-group

````txt [输入]
```js
export default {
    name: 'MyComponent',
    // ...
};
```

```html
<ul>
    <li v-for="todo in todos" :key="todo.id">{{ todo.text }}</li>
</ul>
```
````

```js [输出 js]
export default {
    name: 'MyComponent',
    // ...
};
```

```html [输出 html]
<ul>
    <li v-for="todo in todos" :key="todo.id">{{ todo.text }}</li>
</ul>
```

:::

## 代码块中的行突出显示

::: code-group

````txt [输入]
```js{4}
export default {
  data () {
    return {
      msg: '高亮行!'
    }
  }
}
```
````

```js{4} [输出]
export default {
  data () {
    return {
      msg: '高亮行!'
    }
  }
}
```

:::

::: details 除了单行之外，还可以指定多个单行/行范围：

::: code-group

````txt [输入]
```js{1,4,6-8}
export default { // Highlighted
  data () {
    return {
      msg: `Highlighted!
      This line isn't highlighted,
      but this and the next 2 are.`,
      motd: 'VitePress is awesome',
      lorem: 'ipsum'
    }
  }
}
```
````

```js{1,4,6-8} [输出]
export default { // Highlighted
  data () {
    return {
      msg: `Highlighted!
      This line isn't highlighted,
      but this and the next 2 are.`,
      motd: 'VitePress is awesome',
      lorem: 'ipsum'
    }
  }
}
```

:::

::: details 使用 `// [!code hl]` 注释直接在行中突出显示
::: code-group

````txt [输入]
```js
export default {
  data () {
    return {
      msg: 'Highlighted!' // [!code  hl]
    }
  }
}
```
````

```js [输出]
export default {
    data() {
        return {
            msg: 'Highlighted!', // [!code  hl]
        };
    },
};
```

:::

## 聚焦于代码块

在一行上添加 `// [!code focus]` 注释将聚焦它并模糊代码的其他部分。

此外，还可以使用 `// [!code focus:<lines>]` 定义要聚焦的行数。

::: code-group

````txt [单行聚焦输入]
```js
export default {
  data () {
    return {
      msg: 'Focused!' // [!code  focus]
    }
  }
}
```
````

```js [单行聚焦输出]
export default {
    data() {
        return {
            msg: 'Focused!', // [!code focus]
        };
    },
};
```

````txt [多行聚焦输入]
```js
export default {
  data () {
    // [!code  focus:4]
    return {
      msg: 'Focused!'
    }
  }
}
```
````

```js [多行聚焦输出]
export default {
    data() {
        // [!code focus:4]
        return {
            msg: 'Focused!',
        };
    },
};
```

:::

## 代码块中的彩色差异

在一行上添加 `// [!code --]` 或 `// [!code ++]` 注释将创建该行的差异，同时保留代码块的颜色。

::: code-group

````txt [输入]
```js
export default {
  data () {
    return {
      msg: 'Removed' // [!code  --]
      msg: 'Added' // [!code  ++]
    }
  }
}
```
````

```js [输出]
export default {
    data () {
        return {
            msg: 'Removed' // [!code --]
            msg: 'Added' // [!code ++]
        };
    },
};
```

:::

## 代码块中的错误和警告

在一行上添加 `// [!code warning]` 或 `// [!code error]` 注释将相应地为其着色。

::: code-group

````txt [输入]
```js
export default {
  data () {
    return {
      msg: 'Error', // [!code  error]
      msg: 'Warning' // [!code  warning]
    }
  }
}
```
````

```js [输出]
export default {
    data() {
        return {
            msg: 'Error', // [!code error]
            msg: 'Warning', // [!code warning]
        };
    },
};
```

:::

## 行号

您可以通过配置为每个代码块启用行号：

```ts
export default {
    markdown: {
        lineNumbers: true,
    },
};
```

有关更多详细信息，请参阅 [[markdown 选项]](./config#markdown)。

您可以在受防护的代码块中添加 `:line-numbers` / `:no-line-numbers` 标记，以覆盖配置中设置的值。

::: code-group

````txt [输入]
```ts {1}
// 配置里禁用了行号
const line2 = 'This is line 2'
const line3 = 'This is line 3'
```

```ts:line-numbers {1}
// 使用 :line-numbers 启用行号
const line2 = 'This is line 2'
const line3 = 'This is line 3'
```
````

```ts {1} [禁用行号输出]
// 配置里禁用了行号
const line2 = 'This is line 2';
const line3 = 'This is line 3';
```

```ts:line-numbers {1} [启用行号输出]
// 使用 :line-numbers 启用行号
const line2 = 'This is line 2'
const line3 = 'This is line 3'
```

:::

## 导入代码片段

您可以通过以下语法从现有文件导入代码片段：

::: code-group

```md [输入]
<<< @/assets/vitepress/snippets.ts
```

```ts {1} [禁用行号输出]
// 配置里禁用了行号
const line2 = 'This is line 2';
const line3 = 'This is line 3';
```

```ts:line-numbers {1} [启用行号输出]
// 使用 :line-numbers 启用行号
const line2 = 'This is line 2'
const line3 = 'This is line 3'
```

:::
