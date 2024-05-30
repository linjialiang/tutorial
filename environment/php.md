---
title: 安装 PHP
titleTemplate: 环境搭建教程
---

# 安装 PHP

PHP（`PHP: Hypertext Preprocessor`，超文本预处理器的字母缩写）是一种被广泛应用的开放源代码的多用途脚本语言，它可嵌入到 HTML 中，尤其适合 web 开发。

构建 PHP 时可以直接指定 MySQL 的 socket 路径，所以建议在 MySQL 之后安装

::: tip 提示
也可以在 php.ini 配置文件里指定 MySQL 的 socket 路径
:::

## 扩展库

PHP 扩展库按加载时间可分为：`动态库(共享扩展)` 和 `静态库`

::: details 1. 动态库

动态库是在程序运行时链接的，动态库在编译时不会放到连接的目标程序中，即：可执行文件无法单独运行，动态库扩展名一般为：

| win     | unix   |
| ------- | ------ |
| `*.dll` | `*.so` |

:::

::: details 2. 静态库

静态库是在程序编译时链接的，静态库在编译时会直接整合到目标程序中，编译成功的可执行文件可独立运行，静态库扩展名一般为：

| win     | unix  |
| ------- | ----- |
| `*.lib` | `*.a` |

:::

::: details 3. 动态库和静态库区别

静态编译：静态库将需要的依赖在构建时，已经从系统 `拷贝` 到程序中，执行时就不需要调用系统的库，系统包移除时也不至于会让扩展失效，但是它会额外占用磁盘资源

动态编译：动态库构建了 1 个连接文件(`*.so`) ，用于连接程序和系统对应库的文件，执行时需要调用系统的库以及该库对应的依赖项

- 性能：静态库优于动态库，服务器硬件配置较差的，应该倾向于静态库
- 体积：静态库体积大于动态库
- 升级：静态库升级需要重新构建 PHP，动态库升级只需要重新生成连接文件(`*.so`)即可
- 稳定：静态库更加稳定，对于动态库来讲，如果系统对应库升级，与动态库对应的构建版本不一致，可能会遇到兼容性问题

:::

::: details 4. 扩展库构建类型选择

- 使用频繁的扩展库，推荐使用静态编译
- 更新频繁的扩展库，建议使用动态编译
- 非官方认可扩展库，建议使用动态编译

[官方认可扩展库列表](https://www.php.net/manual/zh/extensions.membership.php) 里的扩展，如有必要均可用静态库的方式构建，安全性和稳定性都由官方验证过

:::

## 准备工作

开始之前我们需要先使用预先准备好的 bash 脚本，解压文件和授权目录，具体参考 [脚本文件](./index#脚本文件)

本次计划构建 2 个 php 版本：

1. `php 7.4.x`
2. `php 8.3.x`

## 静态编译 PECL 扩展 {#pecl-static-bulid}

本次静态编译下面这些 PECL 扩展：

1. apcu
2. redis
3. yaml
4. rdkafka

### 1. 拷贝扩展源码

将 PECL 扩展源码拷贝到 php 的 ext 目录下

::: code-group

```bash [进扩展目录]
cd /home/php-fpm/php_ext
```

```bash [拷贝到8.3]
cp -p -r apcu-5.1.23 /home/php-fpm/php-8.3.7/ext/apcu
cp -p -r redis-6.0.2 /home/php-fpm/php-8.3.7/ext/redis
cp -p -r yaml-2.2.3 /home/php-fpm/php-8.3.7/ext/yaml
```

```bash [拷贝到7.4]
cp -p -r apcu-5.1.23 /home/php-fpm/php-7.4.33/ext/apcu
cp -p -r redis-6.0.2 /home/php-fpm/php-7.4.33/ext/redis
cp -p -r yaml-2.2.3 /home/php-fpm/php-7.4.33/ext/yaml
```

:::

### 2. 重新生成 php 配置

PHP 增加新扩展后，需要使用 `autoconf` 工具重新生成 `配置脚本-configure`

::: details 安装 autoconf 工具

```bash
apt install autoconf -y
```

:::

::: details 重新生成 configure 配置脚本

::: code-group

```bash [8.3重新生成]
cd /home/php-fpm/php-8.3.7/
mv configure{,.original}
./buildconf --force
```

```bash [7.4重新生成]
cd /home/php-fpm/php-7.4.33/
mv configure{,.original}
./buildconf --force
```

:::

## pkg-config

构建 php 时，自己编译的依赖包需要手动加入到 pkg-config 中

使用 export 是临时加入环境变量中，但会永久记录在编译后的可执行文件信息里

### 1. 查看临时环境变量

查看当前终端临时的环境变量，避免多次引入路径，造成混淆

```bash
echo $PKG_CONFIG_PATH
```

### 2. 加入临时环境变量

将所需路径加入到当前终端临时的环境变量中

::: code-group

```bash [加入单个路径]
export PKG_CONFIG_PATH=/path/to/pkgConfig_1:$PKG_CONFIG_PATH
```

```bash [加入多个路径]
export PKG_CONFIG_PATH=/path/to/pkgConfig_1:/path/to/pkgConfig_2:$PKG_CONFIG_PATH
```

:::

### 3. 查看环境变量列表

使用下面指令，可以查看当前终端的全部环境变量列表

```bash
pkg-config --list-all
```

## 构建 PHP

### 1. 安装依赖

本次 PHP 编译，系统还需要如下依赖项：

```bash
apt install g++ libsystemd-dev libsqlite3-dev libcurl4-openssl-dev libffi-dev libgmp-dev libonig-dev libsodium-dev libyaml-dev libzip-dev -y

# php 8.3.0 开始如果要启用 capstone
apt install libcapstone-dev -y

# libpq-dev 包含 libpq库(是 PostgreSQL 官方的客户端库)，用于与 PostgreSQL 服务器进行通信
apt install libpq-dev -y

# rdkafka
apt install librdkafka-dev -y
```

::: tip

- 不同版本所需依赖项可能不同
- 使用更多外部扩展，所需依赖项也会更多
- php 较低版本如果要在新版的 linux 系统上安装，很多依赖都需要自己去重新构建

所以很多时候你要学会去阅读 `configure` 的报错提，以及掌握 linux 软件包的编译安装
:::

### 2. 创建构建目录

```bash
mkdir /home/php-fpm/php-7.4.33/build_php
mkdir /home/php-fpm/php-8.3.7/build_php
```

### 3. 环境变量

构建 PHP 需要额外将 `sqlite3` 的 `pkgconfig` 目录加入到临时环境变量里

```bash
export PKG_CONFIG_PATH=/server/sqlite3/lib/pkgconfig:$PKG_CONFIG_PATH

# 使用下面指令检查，sqlite3 是否正确加入
pkg-config --list-all | grep sqlite3

# 加入成功显示：
sqlite3          SQLite - SQL database engine
```

::: tip 如果服务器上未安装 sqlite3，则需要安装 `libsqlite3-dev` 依赖库，这样也不用将 `pkgconfig` 加入到 PKG_CONFIG_PATH 环境变量中
:::

### 4. 查看构建选项

```bash
# 全部构建选项
./configure -h

# 扩展构建选项
./configure -h | grep redis
./configure -h | grep yaml

# 导出构建选项
./configure -h > configure.txt
```

::: details 构建选项预览
::: code-group
<<<@/assets/environment/source/php/configure/74.ini [7.4]
<<<@/assets/environment/source/php/configure/83.ini [8.3]
:::

### 5. 进入构建目录

```bash
# php7.4 构建目录
cd /home/php-fpm/php-7.4.33/build_php/
# php8.3 构建目录
cd /home/php-fpm/php-8.3.7/build_php/
```

### 6. 安装指令

::: details 构建指令参考
::: code-group
<<<@/assets/environment/source/php/build/83.bash [8.3]
<<<@/assets/environment/source/php/build/74.bash [7.4]
:::

::: tip 构建指令区别：
php8.1 默认已经对 openssl 启用 `pcre-jit` 实现正则即时编译

php8.1 的 gd 扩展增加的 `--with-avif` 选项

php8.3 增加 `--with-capstone` 选项
:::

### 7. 编译并安装

```bash
# nohup make -j2 &
make -j2
make test
make install
```

## PHP 配置

`php.ini` 是 PHP 的配置文件，具体选项可以阅读 [官方手册](https://www.php.net/manual/zh/ini.php)

### 1. 配置文件模板

php 编译完成后，在源码包根目录下会自动生成两个推荐的配置文件模版

- 开发环境推荐： `php.ini-development`
- 部署环境推荐： `php.ini-production`

### 2. 配置文件路径

通过下面的指令可以快速获取到 PHP 配置文件存放路径

::: code-group

```bash [使用 php 程序]
# php7.4
/server/php/74/bin/php --ini
# php8.2
/server/php/82/bin/php --ini
# php8.3
/server/php/83/bin/php --ini
```

```bash [使用 php-config 程序]
# php7.4
/server/php/74/bin/php-config --ini-path
# php8.2
/server/php/82/bin/php-config --ini-path
# php8.3
/server/php/83/bin/php-config --ini-path
```

:::

### 3. 拷贝配置文件 {#copy-config-file}

::: code-group

```bash [部署环境]
# php7.4
cp /home/php-fpm/php-7.4.33/php.ini-production /server/php/74/lib/php.ini
# php8.2
cp /home/php-fpm/php-8.2.12/php.ini-production /server/php/82/lib/php.ini
# php8.3
cp /home/php-fpm/php-8.3.7/php.ini-production /server/php/83/lib/php.ini
```

```bash [开发环境]
# php7.4
cp /home/php-fpm/php-7.4.33/php.ini-development /server/php/74/lib/php.ini
# php8.2
cp /home/php-fpm/php-8.2.12/php.ini-development /server/php/82/lib/php.ini
# php8.3
cp /home/php-fpm/php-8.3.7/php.ini-development /server/php/83/lib/php.ini
```

:::

### 4. 检测配置文件

使用 php 程序，快速检测配置文件使用加载成功

```bash
# php7.4
/server/php/74/bin/php --ini
# php8.2
/server/php/82/bin/php --ini
# php8.3
/server/php/83/bin/php --ini
```

### 5. 开启 OPcache

PHP 官方明确说明 OPcache 只允许编译为共享扩展，并且默认会构建它

使用 `--disable-opcache` 选项可以禁止构建

- 开启方式

  在 `php.ini` 第 953 行，将 `;` 去掉

  ```ini
  zend_extension=opcache
  ```

- 性能配置

  在 `php.ini` 第 1796 行，加入以下内容，可获得较好性能

  ```ini
  # 检查脚本时间戳是否有更新的周期，以秒为单位
  opcache.revalidate_freq=60
  ```

::: danger 警告
开启 `opcache` 扩展，会导致数据被缓存，可能无法获取到最新数据，所以线上环境必须经过严格测试

如果你不明白自己在做什么，最好不要开启它
:::

## PHP-FPM 配置

Nginx 只能处理静态页面，如果要处理 php 脚本，就必须借助 PHP-FPM 这些 FastCGI 进程管理器

1. nginx 将内容转发给 PHP-FPM
2. PHP-FPM 接管 php 统一处理
3. 处理后产生的返回值再返回给 nginx
4. 最终由 nginx 输出

### 1. 配置文件分类

PHP-FPM 配置文件可分成两种

1. 主进程配置文件：管理整个 PHP-FPM 服务的
2. 工作池进程配置文件：管理单个工作池进程的

::: details 主进程：

主进程(master)配置文件，是针对整个 PHP-FPM 的通用配置

- 路径： `/server/php/etc/php-fpm.conf`
- 数量： 有且仅有，1 个
- 需求： 主进程配置文件必须存在
- 默认： 默认未创建
- 模板： `/server/php/etc/php-fpm.conf.default`

:::

::: details 工作池进程：

工作池进程(pool)配置文件，是针对单个工作进程的配置文件

- 路径： `/server/php/etc/php-fpm.d/*.conf`
- 数量： 允许多个
- 需求： 至少需要 1 个工作吃进程配置文件
- 默认： 默认未创建
- 模板： `/server/php/etc/php-fpm.d/www.conf.default`

:::

### 2. 主进程配置文件

PHP-FPM 的主配置文件选项基本上都是使用默认，所以案例选项很少

::: details php 主配置文件案例
::: code-group
<<<@/assets/environment/source/php/83/php-fpm.conf{ini} [8.3]
<<<@/assets/environment/source/php/74/php-fpm.conf{ini} [7.4]
<<<@/assets/environment/source/php/82/php-fpm.conf{ini} [8.2]
:::

### 3. 工作池配置文件

PHP-FPM 工作池进程配置文件有多个，并且支持随意命名，但为了更好的管理，我们最好遵循一些规则：

1. 针对单独站点 : 跟 nginx 站点配置文件命名一致
2. 根据工作池性质 :
   - 接收 tp6 站点，命名 `tp.conf`；
   - 接收其它站点，命名 `default.conf`

::: details 通用工作池案例
::: code-group
<<<@/assets/environment/source/php/83/php-fpm.d/default.conf{ini} [8.3]
<<<@/assets/environment/source/php/74/php-fpm.d/default.conf{ini} [7.4]
<<<@/assets/environment/source/php/82/php-fpm.d/default.conf{ini} [8.2]
:::

::: details 其他工作池案例
::: code-group
<<<@/assets/environment/source/php/83/php-fpm.d/tp.conf{ini} [tp 工作池]
<<<@/assets/environment/source/php/83/php-fpm.d/qy.conf{ini} [勤易工作池]
:::

### 4. 工作进程配置参数

更多参数说明，请阅读 [PHP 手册](https://www.php.net/manual/zh/install.fpm.configuration.php)

```ini
# 子进程名，通常与子进程配置文件命名相同
[default]
user                    = php-fpm    # 子进程用户，默认为 nobody
group                   = php-fpm    # 子进程用户组，默认为 nobody

# 工作池进程对应的监听地址，可选 监听端口 或 socket文件
listen                  = /server/run/php/php81-fpm-default.sock

listen.backlog          = -1        # 设置 listen 的最大值，-1表示无限制，默认值：-1
listen.owner            = nginx       # 子进程监听用户，默认为 nobody，仅支持监听对象是 unix 套接字
listen.group            = nginx       # 子进程监听用户组，默认为 nobody，仅支持监听对象是 unix 套接字
listen.mode             = 0660      # 监听权限，仅支持监听对象是 unix 套接字
listen.allowed_clients  = 127.0.0.1 # 设置允许连接到 FastCGI 的服务器IP，默认仅允许本地访问

pm                      = static    # 设置进程管理器管理的子进程数量是固定的
pm.max_children         = 50        # pm 设置为 static 时表示创建的子进程的数量，pm 设置为 dynamic 时表示最大可创建的子进程的数量
pm.max_requests         = 1000      # 设置每个子进程重生之前服务的请求数，对于可能存在内存泄漏的第三方模块来说是非常有用的
```

## Systemd 管理

PHP-FPM 自带了一套比较完善的进程管理指令，编译完成后还会在构建目录下生成 Systemd Unit 文件

::: details 默认模板

::: code-group
<<<@/assets/environment/source/service/php/83/php-fpm.service{ini} [php8.3]
<<<@/assets/environment/source/service/php/74/php-fpm.service{ini} [php7.4]
:::

::: details 案例参考

::: code-group
<<<@/assets/environment/source/service/php/php83-fpm.service{ini} [php8.3]
<<<@/assets/environment/source/service/php/php74-fpm.service{ini} [php7.4]
:::

::: code-group

```bash [创建单元文件]
mv /path/php*-fpm.service /usr/lib/systemd/system/
```

```bash [加入开机启动]
systemctl enable php74-fpm
systemctl enable php83-fpm
```

```bash [重载Systemd]
systemctl daemon-reload
```

:::

::: tip 注意事项：

1. 1 个 `unix-socket`，对应 1 个 `php-fpm` 工作进程
2. 1 个 php-fpm 工作进程配置文件对应 1 个 unix-socket
3. 多个配置文件，不允许指向同一个 unix-socket，会出现冲突
4. 每个配置文件：
   - 必须设置单独的 `socket` 文件路径，如：tp6.sock、default.sock
   - 可以设置自己的用户，如：www、nginx、php-fpm、nobody

:::

## Composer

Composer 是一个 PHP 依赖管理工具，开发环境必备

::: danger 警告
不建议在部署环境安装 `git` `composer` `npm` 等开发环境工具

请全部在开发环境处理好，然后拷贝进服务器即可
:::

### 1. 安装

推荐直接使用腾讯云镜像 [下载 composer](https://mirrors.tencent.com/composer/composer.phar)

```bash
# 进入 php8.3 的 bin 目录
cd /server/php/83/bin
# 下载 composer.phar
curl -O https://mirrors.tencent.com/composer/composer.phar
# 添加执行权限
chown root:emad composer.phar
chmod 750 composer.phar
# 软链接到当前目录
ln -s /server/php/83/bin/composer.phar /usr/local/bin/composer
```

::: tip 更多国内镜像

> 当前腾讯云是最正常的

- 腾讯云：`composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer/`
- 阿里云：`composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/`
- 华为云：`composer config -g repo.packagist composer https://repo.huaweicloud.com/repository/php/`

:::

### 2. 全量镜像

推荐全局配置阿里云的 Composer 全量镜像

```bash
# 切换到开发者用户
su emad
# 使用阿里云 Composer 全量镜像
/server/php/83/bin/php /usr/local/bin/composer config -g repo.packagist composer https://mirrors.cloud.tencent.com/composer/

# 取消使用阿里云 Composer 全量镜像
/server/php/83/bin/php /usr/local/bin/composer config -g --unset repos.packagist
```

### 3. 升级

升级 composer 也非常简单，建议使用国内全量镜像后再升级

```bash
# 切换到开发者用户
su emad
/server/php/83/bin/php /usr/local/bin/composer -V
/server/php/83/bin/php /usr/local/bin/composer self-update
```

### 4. 加入环境变量中

开发环境可以将 php 主版本的可执行文件加入到用户环境变量中，这样在操作上会便捷很多

下面将 php8.3 版本加入到环境变量中为例

::: details 加入到 bash/zsh 环境变量中

```ini
# 切换到开发者用户
su emad
# ~/.bashrc 和 ~/.zshrc  文件底部增加
PATH=${PATH}:/server/php/83/bin:/server/php/83/sbin
export PATH
```

:::

## 网页版数据库管理工具

将 adminer、phpMyAdmin、phpRedisAdmin 加入到默认站点

```bash
mv adminer-xxx.php /server/default/adminer.php
mv phpMyAdmin-xxx/ /server/default/pma
mv phpRedisAdmin-xxx/ /server/default/pra
```

### 1. adminer

adminer 使用 pdo 链接数据库，支持管理多种数据库，不需要额外配置

::: tip
adminer 无需配置
:::

::: details 将服务器上 sql 文件导入到数据库

```
- sql文件路径：文件必须和 adminer.php 在同级目录下
- sql文件名称：`adminer.sql` 或者 `adminer.sql.gz`
```

:::

### 2. phpMyAdmin

phpMyAdmin 使用 mysqli 链接，支持管理 MariaDB、MySQL

::: tip
phpMyAdmin 需要配置
:::

1. details 新建配置文件

   在 pma 根目录下新建 config.inc.php 文件

   ```bash
   cd /server/default/pma/
   vim config.inc.php
   ```

   ::: details 配置文件内容
   <<<@/assets/environment/source/php/config.inc.php
   :::

   ::: tip
   pma 的密文 `$cfg['blowfish_secret']` 参数需要重新设置
   :::

2. pma 密文参数

   `$cfg['blowfish_secret']` 参数用于设置 pma 密文，支持如下字符类型组合：

   - 数值: `0-9`
   - 大写字母: `A-Z`
   - 小写字母: `a-z`
   - ascii 特殊字符: `\~!@#$%^&*()_+-=[]{}\|;:'"/?.>,<`

### 3. phpRedisAdmin

phpRedisAdmin 需要使用 composer 安装依赖后，才能正常使用

```bash
su emad
cd /server/default/pra/
composer install
```

::: danger 警告
通常不使用 `composer update` 指令，它有可能导致程序依赖被破坏

对于任何线上项目，都应该尽可能减少使用 `composer update` 的次数
:::

## 升级 PHP

升级 PHP 跟正常编译类似，下面我们假设已经下载并解压完毕欲升级的 php 源码包

::: danger 警告
服务器升级 PHP 乃至任何软件升级前，都应该先存快照，备份一份
:::

### 1. 静态编译 PECL 扩展

具体见上述[[静态编译 PECL 扩展]](#pecl-static-bulid)

### 2. 安装依赖

PHP 没有跨大版本更新，并且没有新增扩展，通常不需要安装更多的依赖项

### 3. 创建构建目录

```bash
mkdir /home/php-fpm/php-8.2.12/build_php
```

### 4. 环境变量

将 `sqlite3` 的 `pkgconfig` 目录加入到临时环境变量里

```bash
export PKG_CONFIG_PATH=/server/sqlite3/lib/pkgconfig:$PKG_CONFIG_PATH
```

### 5. 进入构建目录

```bash
# php8.1 构建目录
cd /home/php-fpm/php-8.2.12/build_php/
```

### 6. 构建指令

::: details 8.2 构建指令参考
<<<@/assets/environment/source/php/build/82.bash
:::

### 7. 执行编译

```bash
make -j2
make test
```

::: warning 注意
升级时我们先构建和编译，但不要马上执行安装
:::

### 8. 重命名执行程序

升级之前需要先将 `sbin/php-fpm` 执行文件重命名，这样可以实现升级 PHP 而不影响项目正常运作

```bash
# php8.2
mv /server/php/82/sbin/php-fpm{,-v8.2.4}
```

### 9. 执行安装

```bash
make install
```

### 10. 配置文件

具体见[[拷贝配置文件]](#copy-config-file)

::: info 说明
小版本升级一般不需要修改配置文件、动态扩展也不需要重新构建
:::

::: danger 升级到大版本
大版本升级需要使用新的配置文件，并且动态扩展需要重新构建
:::

### 11. 开启 OPcache

开启 OPcache 扩展，具体操作请参考上述 [OPcache 说明](#_5-开启-opcache)

### 12. Systemd 管理

小版本升级不需要修改 Systemd 单元配置

::: tip 提示
PHP 升级成功后，如果可以的话应该尽可能重启下服务器
:::

## 动态安装 PECL 扩展

在为项目增加功能的时候，可能需要额外的扩展支持，这时候我们不可避免要去安装动态扩展

而 PHP 官方显然也是考虑到这一点，所以动态安装这块也非常轻松

本次计划提供下面几个 PECL 扩展的动态安装案例：

1. [imagick](https://pecl.php.net/package/imagick)
2. [xdebug](https://xdebug.org/download)
3. [swoole](https://www.swoole.com/download)
4. [rdkafka](https://pecl.php.net/package/rdkafka)

### 1. imagick

imagick 需要先安装依赖库 [ImageMagick](https://download.imagemagick.org/ImageMagick/download/)

::: details 安装 ImageMagick

```bash
apt install libtool -y
# 如果 make check 没有报错，下面这些依赖可以不用安装
apt install libheif-dev liblcms2-dev libopenjp2-7-dev liblqr-1-0-dev libopenexr-dev libwmf-dev libpango1.0-dev libraw-dev libraqm-dev libdjvulibre-dev libzstd-dev -y
mkdir /server/ImageMagick
cd /home/php-fpm/ImageMagick-7.1.0-51/
./configure --prefix=/server/ImageMagick/
make
make check
make install
```

:::

::: details 安装 Imagick 扩展

```bash
export PKG_CONFIG_PATH=/server/ImageMagick/lib/pkgconfig
cd /home/php-fpm/php_ext/imagick-3.7.0
phpize
# 构建指令
./configure \
--with-php-config=/server/php/83/bin/php-config \
# --with-php-config=/server/php/82/bin/php-config \
# --with-php-config=/server/php/74/bin/php-config \
--with-imagick=/server/ImageMagick/
# 编译并安装
make
make test
make install
```

> `./configure` 指令检查有报错

:::

### 2. xdebug

xdebug 是 php 的断点调试工具

::: code-group

```bash [编译]
cd /home/php-fpm/php_ext/xdebug-3.3.2
phpize
./configure --enable-xdebug --with-php-config=/server/php/83/bin/php-config
# ./configure --enable-xdebug --with-php-config=/server/php/74/bin/php-config
make -j4
make install
```

```ini [配置]
# /server/php/83/lib/php.ini

[xdebug]
zend_extension=xdebug
xdebug.mode=develop,trace,debug
xdebug.client_host=127.0.0.1
; xdebug.client_host=192.168.6.254
xdebug.client_port=9083
; xdebug.client_port=9074
; xdebug.client_port=9082
```

:::

::: tip 同时使用 Xdebug 和 OPCache 时，`zend_extension=xdebug` 须在 `zend_extension=opcache` 下面：

```ini
zend_extension=opcache
zend_extension=xdebug
```

:::

### 3. swoole

Swoole 是一个使用 C++ 语言编写的基于异步事件驱动和协程的并行网络通信引擎，为 PHP 提供协程、高性能网络编程支持

### 4. rdkafka

::: code-group

```bash [安装]
# 安装依赖库 librdkafka
apt install librdkafka-dev -y

# 安装 php-rdkafka 扩展
cd /home/php-fpm/php_ext/rdkafka-6.0.3
phpize
./configure --with-php-config=/server/php/83/bin/php-config
make -j2
make install
```

```ini [配置]
# /server/php/83/lib/php.ini
extension=rdkafka
```

:::

### 5. MongoDB

在实际工作中 PostgreSQL 通常可以取代 MySQL 和 MongoDB

::: code-group

```bash [安装]
cd /home/php-fpm/php_ext/mongodb-1.19.0
phpize
./configure --enable-mongodb --with-php-config=/server/php/83/bin/php-config
make -j2
make test
make install
```

```ini [配置]
# /server/php/83/lib/php.ini
extension=mongodb
```

:::

::: tip 开启动态扩展

```ini
extension=imagick
extension=swoole
extension=mongodb
extension=rdkafka
```

:::

## 权限

::: code-group

```bash [部署]
chown php-fpm:php-fpm -R /server/php /server/logs/php /server/run/php
find /server/php /server/logs/php -type f -exec chmod 640 {} \;
find /server/php /server/logs/php -type d -exec chmod 750 {} \;
# 可执行文件需要执行权限
chmod 750 -R /server/php/83/bin /server/php/83/sbin
# 如果不设置成 755 php-fpm的监听用户nginx将无法读取和执行 unix socket 文件
# socket 用户nginx/权限660
# pid 用户php-fpm/权限644
chmod 755 /server/run/php
```

```bash [开发]
chown php-fpm:emad -R /server/php /server/logs/php /server/run/php
find /server/php /server/logs/php -type f -exec chmod 640 {} \;
find /server/php /server/logs/php -type d -exec chmod 750 {} \;
# 可执行文件需要执行权限
chmod 750 -R /server/php/83/bin /server/php/83/sbin
# 如果不设置成 755 php-fpm的监听用户nginx将无法读取和执行 unix socket 文件
# socket 用户nginx/权限660
# pid 用户php-fpm/权限644
chmod 755 /server/run/php
```

:::
