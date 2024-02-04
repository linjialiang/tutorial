---
title: 安装 Redis
titleTemplate: 环境搭建教程
---

# 安装 Redis

[redis](https://redis.io/download) 是当下最热门的键值对(Key-Value)存储数据库

在 Debian 12 下构建 Redis 的详细流程如下

## 安装依赖

测试编译结果会用到 tcl

```bash
apt install tcl libssl-dev -y
```

## 权限

::: code-group

```bash [部署]
chown redis:redis -R /server/redis /server/logs/redis /server/run/redis
find /server/redis /server/logs/redis /server/run/redis -type f -exec chmod 640 {} \;
find /server/redis /server/logs/redis /server/run/redis -type d -exec chmod 750 {} \;
chmod 750 -R /server/redis/bin
```

```bash [开发]
chown redis:emad -R /server/redis /server/logs/redis /server/run/redis
find /server/redis /server/logs/redis /server/run/redis -type f -exec chmod 640 {} \;
find /server/redis /server/logs/redis /server/run/redis -type d -exec chmod 750 {} \;
chmod 750 -R /server/redis/bin
```

:::

## 构建安装

Redis 构建相对简单

::: code-group

```bash [构建指令]
su - redis -s /bin/zsh
cd ~/redis-7.2.4/
make BUILD_TLS=yes -j2
```

```bash [检测编译结果]
make test
# 当出现高亮信息 `\o/ All tests passed without errors!` 证明测试通过
# -- 低配虚拟机通常会因为AOF持久化的最大延迟（max_latency）> 40 发出异常报错
*** [err]: Active defrag - AOF loading in tests/unit/memefficiency.tcl
Expected 46 <= 40 (context: type eval line 37 cmd {assert {$max_latency <= 40}} proc ::test)
```

```bash [安装并指定目录]
make install PREFIX=/server/redis
```

:::

::: details 文件说明

刚刚安装好的 Redis 很简洁，只有 1 个 `目录 bin` 和 `bin 下面的 6 个文件`：

| file            | info                    |
| --------------- | ----------------------- |
| redis-benchmark | 用于 Redis 压力测试工具 |
| redis-server    | 启动 Redis 数据库       |
| redis-cli       | Redis 命令工具          |
| redis-check-rdb |                         |
| redis-sentinel  |                         |
| redis-check-aof |                         |

:::

## 配置文件

redis 源码包中自带了 1 个配置文件，我们这里可以直接拷贝该配置文件，按自己需要修改相应配置

### 1. 拷贝配置文件

```bash
cp -p -r ~/redis-7.2.4/redis.conf /server/redis/redis.conf
```

::: code-group

```bash [redis.conf]
# /server/redis/redis.conf

# 以守护进程的方式运行
daemonize yes
# 修改pid文件存放路径
pidfile /server/run/redis/redis.pid
# 启用密码登陆
requirepass 1
# 日志路径
logfile "/server/logs/redis/redis.log"
# 开启本地和局域网
bind 127.0.0.1 192.168.66.254

# ====== 启用混合持久化
# 启用 RDB 持久化
save 3600 1 300 100 60 10000
# 指定本地数据库存放目录 默认的 ./ 遇到过权限问题
# 注意：RDB和AOF文件都将在此目录下创建
dir /server/redis/rdbData

# 启用 AOF 持久化
appendonly yes

# 其它相关参数默认即可
# 启用混合持久化 ======
```

```bash [创建目录]
# redis 用户需要有写入权限
mkdir /server/redis/data
```

```bash [sysctl.conf]
# /etc/sysctl.conf

# 控制进程是否允许使用虚拟内存
#   - 0：进程只能使用物理内存
#   - 1：进程可以使用比物理内存更多的虚拟内存
vm.overcommit_memory = 1
```

:::

### 2. 配置文件参数

::: details 下面是 Redis 配置文件常见的参数：

1.  `daemonize no`

    Redis 默认不是以守护进程的方式运行，可以通过该配置项修改，使用 yes 启用守护进程（Windows 不支持守护线程的配置为 no ）

2.  `pidfile /var/run/redis.pid`

    Redis 默认不是以守护进程的方式运行，可以通过该配置项修改，使用 yes 启用守护进程（Windows 不支持守护线程的配置为 no ）

3.  `port 6379`

    指定 Redis 监听端口，默认端口为 6379，作者在自己的一篇博文中解释了为什么选用 6379 作为默认端口，因为 6379 在手机按键上 MERZ 对应的号码，而 MERZ 取自意大利歌女 Alessia Merz 的名字

4.  `bind 127.0.0.1 -::1`

    绑定的主机地址

5.  `timeout 300`

    当客户端闲置多长秒后关闭连接，如果指定为 0 ，表示关闭该功能

6.  `loglevel notice`

    指定日志记录级别，Redis 总共支持四个级别：debug、verbose、notice、warning，默认为 notice

7.  `logfile ""`

    日志记录方式，默认为标准输出，如果配置 Redis 为守护进程方式运行，而这里又配置为日志记录方式为标准输出，则日志将会发送给 /dev/null

8.  `databases 16`

    设置数据库的数量，默认数据库为 16，可以使用 SELECT 命令在连接上指定数据库 id

9.  `save <seconds> <changes> [<seconds> <changes> ...]`

    指定在多长时间内，有多少次更新操作，就将数据同步到数据文件，可以多个条件配合，Redis 默认配置文件中提供了三个条件：

    `save 3600 1 300 100 60 10000`: 3600 秒（1 小时）内有 1 个更改；300 秒（5 分钟）内有 100 个更改；60 秒内有 10000 个更改

10. `rdbcompression yes`

    指定存储至本地数据库时是否压缩数据，默认为 `yes`，Redis 采用 LZF 压缩，如果为了节省 CPU 时间，可以关闭该选项，但会导致数据库文件变的巨大

11. `dbfilename dump.rdb`

    指定本地数据库文件名，默认值为 `dump.rdb`

12. `dir ./`

    指定本地数据库存放目录

13. `slaveof <masterip> <masterport>`

    设置当本机为 slave 服务时，设置 master 服务的 IP 地址及端口，在 Redis 启动时，它会自动从 master 进行数据同步

14. `masterauth <master-password>`

    当 master 服务设置了密码保护时，slave 服务连接 master 的密码

15. `requirepass foobared`

    设置 Redis 连接密码，如果配置了连接密码，客户端在连接 Redis 时需要通过 `AUTH <password>` 命令提供密码，默认关闭

16. `maxclients 10000`

    设置同一时间最大客户端连接数，默认 10000，Redis 可以同时打开的客户端连接数为 Redis 进程可以打开的最大文件描述符数，如果设置 `maxclients 0`，表示不作限制。

    当客户端连接数到达限制时，Redis 会关闭新的连接并向客户端返回 `max number of clients reached` 错误信息

17. `maxmemory <bytes>`

    指定 Redis 最大内存限制，Redis 在启动时会把数据加载到内存中，达到最大内存后，Redis 会先尝试清除已到期或即将到期的 Key，当此方法处理后，仍然到达最大内存设置，将无法再进行写入操作，但仍然可以进行读取操作。Redis 新的 vm 机制，会把 Key 存放内存，Value 会存放在 swap 区

18. `appendonly no`

    指定是否在每次更新操作后进行日志记录，Redis 在默认情况下是异步的把数据写入磁盘，如果不开启，可能会在断电时导致一段时间内的数据丢失。因为 redis 本身同步数据文件是按上面 save 条件来同步的，所以有的数据会在一段时间内只存在于内存中。默认为 no

19. `appendfilename appendonly.aof`

    指定更新日志文件名，默认为 appendonly.aof

20. `appendfsync everysec`

    指定更新日志条件，共有 3 个可选值：

    - no：表示等操作系统进行数据缓存同步到磁盘（快）
    - always：表示每次更新操作后手动调用 fsync() 将数据写到磁盘（慢，安全）
    - everysec：表示每秒同步一次（折中，默认值）

21. `vm-enabled no`

    指定是否启用虚拟内存机制，默认值为 no，简单的介绍一下，VM 机制将数据分页存放，由 Redis 将访问量较少的页即冷数据 swap 到磁盘上，访问多的页面由磁盘自动换出到内存中（在后面的文章我会仔细分析 Redis 的 VM 机制）

22. `vm-swap-file /tmp/redis.swap`

    虚拟内存文件路径，默认值为 /tmp/redis.swap，不可多个 Redis 实例共享

23. `vm-max-memory 0`

    将所有大于 vm-max-memory 的数据存入虚拟内存，无论 vm-max-memory 设置多小，所有索引数据都是内存存储的(Redis 的索引数据就是 keys)，也就是说，当 vm-max-memory 设置为 0 的时候，其实是所有 value 都存在于磁盘。默认值为 0

24. `vm-page-size 32`

    Redis swap 文件分成了很多的 page，一个对象可以保存在多个 page 上面，但一个 page 上不能被多个对象共享，vm-page-size 是要根据存储的 数据大小来设定的，作者建议如果存储很多小对象，page 大小最好设置为 32 或者 64bytes；如果存储很大大对象，则可以使用更大的 page，如果不确定，就使用默认值

25. `vm-pages 134217728`

    设置 swap 文件中的 page 数量，由于页表（一种表示页面空闲或使用的 bitmap）是在放在内存中的，，在磁盘上每 8 个 pages 将消耗 1byte 的内存。

26. `vm-max-threads 4`

    设置访问 swap 文件的线程数,最好不要超过机器的核数,如果设置为 0,那么所有对 swap 文件的操作都是串行的，可能会造成比较长时间的延迟。默认值为 4

27. `glueoutputbuf yes`

    设置在向客户端应答时，是否把较小的包合并为一个包发送，默认为开启

28. `hash-max-zipmap-[entries|value]`

    指定在超过一定的数量或者最大的元素超过某一临界值时，采用一种特殊的哈希算法

    ```txt
    hash-max-zipmap-entries 64
    hash-max-zipmap-value 512
    ```

29. `activerehashing yes`

    指定是否激活重置哈希，默认为开启（后面在介绍 Redis 的哈希算法时具体介绍）

30. `include /path/to/local.conf`

    指定包含其它的配置文件，可以在同一主机上多个 Redis 实例之间使用同一份配置文件，而同时各个实例又拥有自己的特定配置文件

:::

### 3. 混合持久化

Redis 的持久化是它的一大特性，可以将内存中的数据写入到硬盘中；

Redis 分为 RDB 和 AOF 两种持久化，其中 `AOF` 可以结合 `RDB` 实现混合持久化。

::: code-group

```bash [RDB配置]
# RDB是快照(Snapshotting)全量备份，只能恢复最近1次的快照

# 启用 RDB 持久化，后面的3组数字表示自动快照策略
# - 3600秒（60分钟）内有至少1个key发生变化；
# - 300秒（5分钟）内有至少100个key发生变化；
# - 60秒（1分钟）内有至少1万个key发生变化；
save 3600 1 300 100 60 10000 # 如果设为 save "" 代表关闭
# 当后台保存出错时，是否停止写入操作。
# - 默认为yes，表示如果后台保存失败，那么Redis将停止接收写请求。
stop-writes-on-bgsave-error yes
# 是否开启RDB文件压缩。
# - 默认为yes，表示Redis会在保存RDB文件时进行压缩，以节省磁盘空间。
rdbcompression yes
# 是否开启RDB文件校验和。
# - 默认为yes，表示Redis会在保存RDB文件时计算校验和，用于检查RDB文件是否损坏。
rdbchecksum yes
# 指定RDB文件的名称。默认为 dump.rdb
dbfilename dump.rdb
# 是否删除旧的RDB文件。默认为no，表示Redis不会删除旧的RDB文件。
rdb-del-sync-files no
# 指定RDB文件的存储目录
# - 注意：AOF文件，也将在此目录中创建
dir /server/redis/rdbData
```

```bash [AOF配置]
# AOF 全称 “APPEND ONLY MODE” 是实时记录操作，默认配置可以恢复1秒前的数据
# -- AOF还可以通过混合持久化的方式，结合RDB的快照来提高启动效率和数据恢复的速度。

# 是否开启AOF持久化。
# - 默认为no，表示关闭AOF持久化。
# - 如果设置为yes，则开启AOF持久化。
appendonly yes
# 指定AOF文件的名称。默认为 appendonly.aof
appendfilename "appendonly.aof"
# 指定AOF文件的存储目录。默认为当前工作目录
appenddirname "appendonlydir"
# 设置AOF文件同步的频率。
# - 默认为 everysec，表示每秒同步一次。
# - 可选值有 everysec/always/no
appendfsync everysec
# 在AOF重写期间是否进行同步。
# - 默认为no，表示在AOF重写期间不进行同步。
# - 如果设置为yes，则在AOF重写期间进行同步。
no-appendfsync-on-rewrite no
# 设置自动触发AOF重写的条件，即当AOF文件大小超过上一次重写后大小的百分之多少时触发。
# - 默认为100，表示每次重写都会触发。
auto-aof-rewrite-percentage 100
# 设置自动触发AOF重写的最小文件大小。默认为 64Mb
auto-aof-rewrite-min-size 64mb
# 当AOF文件被截断时，是否加载截断后的AOF文件。
# - 默认为yes，表示加载截断后的AOF文件。
aof-load-truncated yes
# 是否在AOF文件中添加RDB格式的前导部分。
# - 默认为yes，表示添加前导部分。
aof-use-rdb-preamble yes # yes即开启混合持久化 整体格式为：[RDB file][AOF tail]
# 是否在AOF文件中添加时间戳。
# - 默认为no，表示不添加时间戳。
aof-timestamp-enabled no
```

:::

## 配置 redis 系统单元

推荐统一使用 systemd 管理各种服务

::: details 系统单元配置
<<<@/assets/environment/source/service/redis.service{ini}
:::

### 1. 具体操作：

```bash
mv redis.service /usr/lib/systemd/system/
systemctl enable redis
systemctl daemon-reload
```

### 2. 管理单元

| common                          | info         |
| ------------------------------- | ------------ |
| systemctl start redis.service   | 立即激活单元 |
| systemctl stop redis.service    | 立即停止单元 |
| systemctl restart redis.service | 重新启动     |

### 3. 查看启动状态

```bash
ps -ef|grep -E "redis|PID" |grep -v grep
ps aux|grep -E "redis|PID" |grep -v grep
```

## 启用 SSL 功能

Redis 支持通过 SSL/TLS 协议进行加密通信，可以提供更高的安全性。要启动 Redis 的 SSL 功能，需要按照以下步骤进行配置：

::: code-group

```bash [服务器端key]
# 在启动 Redis 之前，需要生成自签名证书和密钥文件
su - redis -s /bin/zsh
cd /server/redis
openssl req -x509 -newkey rsa:4096 -keyout redis.key -out redis.crt -days 36500 -nodes
chmod 600 redis.key
chmod 644 redis.crt
```

```bash [客户端key]
# 可以为客户端生成单独的自签名证书和密钥文件
su - redis -s /bin/zsh
cd /server/redis
openssl req -x509 -newkey rsa:4096 -keyout redis.key -out redis.crt -days 36500 -nodes
chmod 600 client.key
chmod 644 client.crt
```

```bash [修改 Redis 配置文件]
# /server/redis/redis.conf
# 在 Redis 的配置文件中添加以下内容：
port 0 # 禁用非ssl链接
tls-port 6379
tls-cert-file /server/redis/redis.crt
tls-key-file /server/redis/redis.key
tls-client-cert-file client.crt
tls-client-key-file client.key
```

:::
