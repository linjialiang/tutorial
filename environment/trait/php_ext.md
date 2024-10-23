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
cd /home/php-fpm/php_ext/redis-6.1.0
phpize
./configure --enable-redis --with-php-config=/server/php/83/bin/php-config
make -j4
make install
```

:::

::: tip 提示
主数据库相关扩展，建议以静态编译为佳。如：MySQL/PostgreSQL/MariaDB 等关系型数据库
:::

### MongoDB

在实际工作中 PostgreSQL 通常可以取代 MySQL 和 MongoDB

::: code-group

```bash [安装]
cd /home/php-fpm/php_ext/mongodb-1.20.0
phpize
./configure --enable-mongodb --with-php-config=/server/php/83/bin/php-config
make -j4
make test
make install
```

```ini [配置]
# /server/php/83/lib/php.ini
extension=mongodb
```

:::

### 5. yaml

::: code-group

```bash [安装]
cd /home/php-fpm/php_ext/yaml-2.2.4
phpize
./configure --enable-yaml --with-php-config=/server/php/83/bin/php-config
make -j4
make test
make install
```

```ini [配置]
# /server/php/83/lib/php.ini
extension=yaml
```

:::

### 5. apcu

::: code-group

```bash [安装]
cd /home/php-fpm/php_ext/apcu-5.1.24
phpize
./configure --enable-apcu --with-php-config=/server/php/83/bin/php-config
make -j4
make test
make install
```

```ini [配置]
# /server/php/83/lib/php.ini
extension=mongodb
```

:::

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
# --with-php-config=/server/php/74/bin/php-config \
--with-imagick=/server/ImageMagick/
# 编译并安装
make
make test
make install
```

> `./configure` 指令检查有报错

:::

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
