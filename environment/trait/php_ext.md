项目运行过程中，可能需要额外的扩展支持，这时我们不可避免要去安装动态扩展

::: tip 依赖支持
使用 phpize 初始化 configure 配置文件时，需要 `autoconf` 扩展支持

```bash
apt install autoconf -y
```

:::

### xdebug 扩展

[xdebug](https://xdebug.org/download) 扩展安装案例：

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
```

:::

::: tip 提示

同时使用 Xdebug 和 OPCache 时，`zend_extension=xdebug` 须在 `zend_extension=opcache` 之后：

```ini
zend_extension=opcache
zend_extension=xdebug
```

:::

### redis 扩展

::: details redis 扩展

```bash
cd ~/redis-6.0.2
phpize
./configure --enable-redis --with-php-config=/server/php/83/bin/php-config
make -j4
make install
```

:::

::: tip 提示
主数据库相关扩展，建议以静态编译为佳。如：MySQL/PostgreSQL/MariaDB 等关系型数据库
:::
