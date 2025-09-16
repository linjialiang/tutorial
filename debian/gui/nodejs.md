# NodeJS

## 安装 nodejs

apt 源自带的 nodejs 版本比较低，下面使用 nodejs 官方最新稳定包安装

::: code-group

```bash [下载并解压]
wget https://nodejs.org/dist/v18.18.0/node-v18.18.0-linux-x64.tar.xz
tar -xJf node-v18.17.1-linux-x64.tar.xz -C /server/
mv ~/node{-v18.17.1-linux-x64,}
```

```bash [设置权限]
chown emad:emad -R ~/node
```

```bash [加入环境变量]
# ~/.zshrc
PATH=${PATH}:~/node/bin
export PATH
```

:::

## 配置 npm 源

将 npm 源修改成淘宝镜像，如使用官方源，可能需要用到代理工具

```bash
# 查看当前源地址
npm config get registry
# 将源设为淘宝镜像
npm config set registry https://registry.npmmirror.com/
# 恢复默认
npm config set registry https://registry.npmjs.org
```

## 安装 nrm

nrm 用户切换 npm 各种源

```bash
# 安装
npm i nrm -g
# 查看所有镜像列表
nrm list
# 切换到淘宝镜像
nrm use taobao
```

## 常用全局包安装

::: code-group

```bash [正常]
# 升级 npm 到最新
npm update npm -g
# 安装 pnpm
npm i pnpm -g
```

```bash [代理]
# 升级 npm 到最新
proxychains npm update npm -g
# 安装 pnpm
proxychains npm i pnpm -g
```

:::

## nvm

nvm 用于管理 nodejs 版本，在当前用户下安装即可，不需要使用 root 用户权限

1.  node、nvm、npm、npx 区别

    node：是一个基于 Chrome V8 引擎的 JS 运行环境。

    npm：是 node.js 默认的包管理系统（用 JavaScript 编写的），在安装的 node 的时候，npm 也会跟着一起安装，管理 node 中的第三方插件。

    npx：npm 从 v5.2.0 开始新增了 npx 命令，>= 该版本会自动安装 npx，附带：npx 有什么作用跟意义？为什么要有 npx？什么场景使用？。

    nvm：node 版本管理器，也就是说：一个 nvm 可以管理多个 node 版本（包含 npm 与 npx），可以方便快捷的 安装、切换 不同版本的 node。

2.  node、nvm、npm、npx 关系

    nvm 管理 node (包含 npm 与 npx) 的版本，npm 可以管理 node 的第三方插件。

    切换不同的 node 版本，npm 与 npx 的版本也会跟着变化。

    ```bash
    # 可用别名 nvm use lts/gallium
    nvm use 16.19.0
    Now using node v16.19.0 (npm v8.19.3)

    # 可用版本号 nvm use 14.21.2
    nvm use lts/fermium
    Now using node v14.21.2 (npm v6.14.17)

    # 使用系统自带的 nodejs 版本
    nvm use system
    Now using system version of node: v18.17.1 (npm v9.4.1)
    ```

### 安装 nvm

```bash
proxychains4 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc

# 测试
nvm -v
```

### nvm 使用淘宝镜像

```bash
# ~/.zshrc 或 ~/.bashrc
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
export NVM_IOJS_ORG_MIRROR=https://npm.taobao.org/mirrors/iojs
```

### nvm 常用指令

| 功能                 | 指令                      |
| -------------------- | ------------------------- |
| 查看可安装的远程版本 | `nvm list available`      |
| 安装稳定版           | `nvm install stable`      |
| 安装长期支持版       | `nvm install lts`         |
| 安装指定版本         | `nvm install <version>`   |
| 指定删除已安装的版本 | `nvm uninstall <version>` |

```bash
# 列出所有可安装的远程版本
nvm list available

# 列出所有已安装版本
nvm ls

# 安装长期支持版 node
nvm install lts

# 安装稳定版 node
nvm install stable

# 安装指定版本，可模糊安装，如：4.4 等于 4.4.0，也可以指定别名
nvm install <version>

# 删除已安装的指定版本，语法与 install 用法一致
nvm uninstall <version>

# 切换使用指定的版本 node
# 1. 临时版本 - 只在当前窗口生效指定版本
nvm use <version>
# 2. 永久版本 - 所有窗口生效指定版本
nvm alias default <version>

# 显示当前的版本
nvm current

# 给不同的版本号添加别名
nvm alias <name> <version>

# 删除已定义的别名
nvm unalias <name>

# 在当前版本 node 环境下，重新全局安装指定版本号的 npm 包
nvm reinstall-packages <version>

# 查看更多命令可在终端输入
nvm --help
```

### 卸载 nvm

```bash
# 删除数据
rm -rf ~/.nvm
# ~/.zshrc 或 ~/.bashrc 里相关的环境变量删除
```
