---
title: 配置
titleTemplate: VitePress 教程
---

# {{ $frontmatter.title }}

本篇讲解 VitePress 常见配置

## 命令行界面

使用指定目录作为根目录启动 VitePress 开发服务器。默认为当前目录。

在当前目录中运行时，也可以省略 `dev` 命令。

```bash
# 在当前目录中启动，可以省略 `dev`
vitepress

# 在子目录 ./docs 中启动
vitepress dev docs

# 在子目录 ./demo/docs 中启动
vitepress dev demo/docs
```

| Option          | Description                                      |
| --------------- | ------------------------------------------------ |
| `--open [path]` | 启动时打开浏览器 （ `boolean \| string` ）       |
| `--port <port>` | 指定端口 （ `number` ）                          |
| `--base <path>` | 公共基本路径 （默认： `/` ） （ `string` ）      |
| `--cors`        | Enable CORS                                      |
| `--strictPort`  | 如果指定的端口已在使用中，则退出 （ `boolean` ） |
| `--force`       | 强制优化程序忽略缓存并重新捆绑 （ `boolean` ）   |

### vitepress build

构建用于生产的 VitePress 网站。

```bash
vitepress build [root]
```

| Option                         | Description                                                                                         |
| ------------------------------ | --------------------------------------------------------------------------------------------------- |
| `--base <path>`                | 公共基本路径 （默认： `/` ） （ `string` ）                                                         |
| `--target <target>`            | 转译目标 （默认：`"modules"` ） （ `string` ）                                                      |
| `--outDir <dir>`               | 输出目录 （默认： `.vitepress/dist` ） （ `string` ）                                               |
| `--minify [minifier]`          | 启用/禁用缩小，或指定要使用的缩小器（默认： `"esbuild"` ） （ `boolean \| "terser" \| "esbuild"` ） |
| `--assetsInlineLimit <number>` | 静态资产 base64 内联阈值（以字节为单位）（默认值： `4096` ） （ `number` ）                         |

### vitepress preview

本地预览生产版本

```bash
vitepress preview [root]
```

| Option          | Description                                 |
| --------------- | ------------------------------------------- |
| `--base <path>` | 公共基本路径 （默认： `/` ） （ `string` ） |
| `--port <port>` | 指定端口 （ `number` ）                     |

### vitepress init

在当前目录中启动安装向导。

```bash
vitepress init
```
