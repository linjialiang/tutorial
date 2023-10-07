---
title: 命令行界面
titleTemplate: VitePress 教程
---

# 命令行界面

## `vitepress dev`

`vitepress dev` 使用指定的目录作为根目录启动 VitePress 开发服务器。默认为当前目录。在当前目录下运行时，也可以省略 `dev` 命令。

### 使用

```bash
# 在当前目录中启动，省略`dev`
vitepress

# 在子目录中启动
vitepress dev [root]
```

### 选项

| options         | 描述                                            |
| --------------- | ----------------------------------------------- |
| `--open [path]` | 启动时打开浏览器（`boolean \| string`）         |
| `--port <port>` | 指定端口（`number`）                            |
| `--base <path>` | 公共基路径（默认值：`/`）（`string`）           |
| `--cors`        | 启用 CORS                                       |
| `--strictPort`  | 如果指定端口已在使用中，则退出（`boolean`）     |
| `--force`       | 强制优化器忽略该高速缓存并重新绑定（`boolean`） |

## `vitepress build`

构建 VitePress 网站用于生产。

### 使用

```bash
vitepress build [root]
```

### 选项

| options                        | 描述                                                                                             |
| ------------------------------ | ------------------------------------------------------------------------------------------------ |
| `--mpa`（实验）                | 在 `MPA 模式` 下构建（多页面）（`boolean`）                                                      |
| `--base <path>`                | 公共基路径（默认值：`/`）（`string`）                                                            |
| `--target <target>`            | Transpile 目标（默认：`"modules"`）（`string`）                                                  |
| `--outDir <dir>`               | 相对于 cwd 的输出目录（默认值：`<root>/.vitepress/dist`）（`string`）                            |
| `--minify [minifier]`          | 启用/禁用缩小，或指定要使用的缩小器（默认值：`"esbuild"`）（`boolean \| "terser" \| "esbuild"`） |
| `--assetsInlineLimit <number>` | 静态资产 base64 内联阈值（以字节为单位）（默认值：`4096`）（`number`）                           |

## `vitepress preview`

本地预览生产版本。

### 使用

```bash
vitepress preview [root]
```

### 选项

| options         | 描述                                  |
| --------------- | ------------------------------------- |
| `--base <path>` | 公共基路径（默认值：`/`）（`string`） |
| `--port <port>` | 指定端口（`number`）                  |

## `vitepress init`

在当前目录中启动 [安装向导](./../guide/introduction/quickstart#setup-wizard)。

### 使用

```bash
vitepress init
```
