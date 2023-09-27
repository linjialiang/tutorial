---
title: Samba
titleTemplate: Debian 教程
---

# {{ $frontmatter.title }}

Samba 是用来让 UNIX 系列的操作系统与微软 Windows 操作系统的 SMB 网络协定做连结。

简单来讲，最核心的就是 UNIX 与 Windows 实现文件共享

## 安装

```bash
apt install samba -y
```

::: tip 守护进程

- samba-ad-dc : 处理域控制器
- smbd : 处理文件服务、处理打印服务、处理授权与被授权
- nmbd : 处理，名字解析、浏览服务

::: code-group

```bash [samba-ad-dc]
service amba-ad-dc start
service amba-ad-dc stop
service amba-ad-dc restart
```

```bash [smbd]
service smbd start
service smbd stop
service smbd restart
```

```bash [nmbd]
service nmbd start
service nmbd stop
service nmbd restart
```

:::

## 管理

::: code-group

```bash [测试]
# 测试 samba.conf 配置文件正确性
testparm
```

```bash [客户端列表]
# 列出当前 smbd 服务器上的连接客户端
smbstatus
```

:::

### 指令集

> 管理 samba 用户指令集

| common                    | info                                          |
| ------------------------- | --------------------------------------------- |
| pdbedit -a `user-name`    | 添加系统用户为 smb 用户                       |
| pdbedit -x `user-name`    | 删除 smb 用户                                 |
| pdbedit -L `user-name`    | 列出 smb 用户列表，读取 passdb.tdb 数据库文件 |
| pdbedit -L -v `user-name` | 列出 smb 用户列表，并附带详细信息             |
| pdbedit -h                | 查看更多相关指令                              |

> 管理 samba 的用户密码

| common                   | info                            |
| ------------------------ | ------------------------------- |
| smbpasswd -a `user-name` | 系统用户添加为 smb 用户         |
| smbpasswd -d `user-name` | 禁用 smb 用户                   |
| smbpasswd -e `user-name` | 启用 smb 用户                   |
| smbpasswd -n `user-name` | 将指定用户的 smb 密码设置为空   |
| smbpasswd -x `user-name` | 将系统用户从 smb 用户列表中删除 |
| smbpasswd -h             | 查看更多相关指令                |

::: tip 提示：
smbpasswd 和 pdbedit 命令对应着同一个数据库，所以两者可以混合使用
:::

## samba 配置文件

samba 虽然有多个守护进程，但是配置项都在 `/etc/samba/smb.conf` 文件里

```bash
cp /etc/samba/smb.conf{,.bak}
vim /etc/samba/smb.conf
```

### 1. 配置文件内容分类

samba 的配置文件内容主要分为以下 3 类：

1. 全局模块： `[global]`
2. 默认共享模块： `[homes]`
3. 共享模块： `[自定义共享名]`

### 2. 全局模块参数

全局模块参数需要掌握的参数很少，通常默认即可，具体如下：

### 3. security

作用：设置用户认证方式

格式: security = [参数值]

默认: security = user

共有 4 个可选值：

1. `user` : 共享目录只能被授权的用户访问，账号和密码需要通过 pdbedit 或 smbpasswd 建立
2. `domain` : 将身份验证交由域控制器负责，基本用不到
3. `share` : 所有人都可以访问这台 samba 服务器 (4.x 后移除该值)
4. `server` : 与 user 相同，只是将身份验证交由指定的另一台 samba 服务器负责（4.x 后移除该值）

### 4. map to guest

固定格式: `map to guest = bad user`

参数说明：如果登陆的用户名密码错误，自动转换成 guest 登陆

### 5. usershare allow guests

作用：是否允许 guest 登陆(匿名登陆)，其中 guest 默认映射到 nobody 系统用户

格式: `usershare allow guests = <yes|no>`

默认：`usershare allow guests = yes`

| 可选值 | 说明               |
| ------ | ------------------ |
| `yes`  | 允许匿名用户登陆   |
| `no`   | 不允许匿名用户登陆 |

### 6. 全局模块组合案例：

::: code-group

```ini [允许匿名登录]
# 允许匿名用户登陆共享
security = user
usershare allow guests = yes
```

```ini [登录失败转匿名]
# 允许登陆失败的用户，转成匿名用户登陆共享：
security = user
usershare allow guests = yes
map to guest = bad user
```

:::

### 7. 默认共享模块

其它共享模块的配置文件种没有设置的参数，将自动获取该模块里的参数

具体参数见下面的 `自定义共享模块`

### 8. 自定义共享模块

samba 配置文件下，可以根据自己需要，配置多个共享分组

::: details 具体参数如下：

```ini
[group]                             # 该共享分组名
browseable = yes/no                 # 指定该共享是否可以浏览
create mask = 0640                  # 上传文件权限
directory mask = 0750               # 上传目录权限
comment = message                   # 该共享分组描述
path = to/path                      # 该共享分组路径
valid users = user1, user2          # 允许访问该共享的用户
write list = user1, user2, @group1  # 允许写入该共享的用户
force group = test                  # 指定上传文件的所属用户为 test
force user = test                   # 指定上传文件的所属用户组为 test
read only = yes/no                  # 指定该共享路径是否只读
admin users = user1, @group1        # 此列表的用户将映射为 系统用户 root 登陆
guest ok = yes/no                   # 指定该共享是否允许 guest 账户访问
invalid users = user1, user2        # 禁止访问该共享的用户
```

:::

::: tip 提示：
`writable` 和 `read only` 不能同时设置成 `yes`！
:::

::: details www 用户登录，上传文件所属用户为 www：

```bash
[www]
    browseable = yes
    create mask = 0640
    directory mask = 0750
    comment = "sites root dir"
    path = /www
    valid users = emad
    write list = emad
    force group = emad
    force user = emad
[git]
    browseable = yes
    create mask = 0640
    directory mask = 0750
    comment = "git repository root dir"
    path = /home/emad/git
    valid users = emad
    write list = emad
    force group = emad
    force user = emad
```

:::

::: details www 用户登录，上传文件所属用户为 root:

```bash
[server]
    browseable = yes
    create mask = 0644
    directory mask = 0755
    comment = "nginx sites config dir"
    path = /server
    valid users = emad
    write list = emad
    force group = root
    force user = root
    admin users = emad
```

:::

### 8. 共享目录权限说明

- 浏览文件 : 登陆用户必须有读权限
- 下载文件 : 登陆用户必须有读权限
- 上传文件 : 登陆用户必须有写权限
- 修改文件 : 登陆用户必须有写权限

> 提示：samba 配置文件设定的权限和 linux 系统设置的权限必须同时具备，才能拥有对应操作权限！

## 创建 samba 用户

推荐使用 pdbedit 将系统用户映射到 samba 用户列表中

推荐使用 smbpasswd 来对 samba 用户列表中的用户修改密码

只要掌握 pdbedit 和 smbpasswd 其中一个，就能配置 samba

### 1. 创建系统用户

```bash
groupadd test
useradd -c 'this is samba user' -u 3001 -M -g test test
```

### 2. 映射系统用户

系统用户映射到 samba，用于 samba 客户端登录用户

```bash
pdbedit -a test
# 或者
pdbedit -a -u test
```

### 3. 删除 smb 用户

```bash
pdbedit -x test
```

### 4. 查看 smb 用户

```bash
pdbedit -L
# 或者
pdbedit -Lv
```

### 5. 修改 smb 用户密码

```bash
# smbpasswd 用户名
smbpasswd test
```

## windows 下切换已登录的共享资源

1. 打开 `运行` -> 输入 `cmd` -> 按回车 -> 输入 `net use \* /del /y`

2. 输入 `win+e` 打开资源管理器 -> 在任务管理器中重启资源管理器

3. 打开 `运行` -> 输入 `\\192.168.10.251` -> 之后就会提示重新登陆账号密码

::: tip 如果是选择了记住凭据，还需要去控制面板修改密码：

```
- 控制面板 -> 所有控制面板项 -> 凭据管理器 -> Windows 凭据
- 找到该凭据， 一般带有后面中括号里的字样 【\\192.168.10.254】
- 可以直接删除掉，也可以选择修改账户密码
- 最后，重启资源管理器
```

:::

## 利用 samba 实现局域网开发注意事项

1. 将 samba 用户及用户组设置为 www
2. 将 /server/www 目录设置为 smb 家目录
3. 将系统用户 www 设为 /bin/bash 方式登陆，方便 composer 操作
4. /server/www 目录权限设为 750（vsftpd 会无法正常登录该目录）
5. 直接将服务器上的项目加入到编辑器上，即可实现局域网开发

::: details 案例如下：

```bash
mkdir -p /server/www /server/default /server/sites
usermod -s /bin/bash www
chown www:www /server/www
chmod 750 /server/www
chown root:root /server/default /server/sites
chmod 755 /server/default
```

:::

## 阻止来宾访问问题

提示语：你不能访问此共享文件夹，因为你组织的安全策略阻止未经身份验证的来宾访问

1. 按 `window+R` 键输入 `gpedit.msc` 来启动本地组策略编辑器
2. 找到 `计算机配置-管理模板-网络-Lanman工作站` ，在右侧内容区 `启用不安全的来宾登录` 状态是 `未配置` 我们修改成 `已启用`
