---
title: 概述
titleTemplate: 其他文档
---

# 其他文档概述

## 正则记录

::: details 127 网段正则匹配

正则匹配：127.<0-255>.<0-255>.<0-254>

```txt
^127(?:\.(?:(?:[1-9]?\d)|(?:1\d{2})|(?:2[0-4]\d)|(?:25[0-5]))){2}\.(?:(?:[1-9]\d?)|(?:1\d{2})|(?:2[0-4]\d)|(?:25[0-4]))$
```

:::

## 自签名证书创建流程

通常使用 OpenSSL 工具来创建自签名证书，下面是生成双向验证所需的证书流程：

::: code-group

```bash [CA根证书]
# ca.{crt,key} 自签名CA证书和CA私钥
openssl req -newkey rsa:2048 -nodes -keyout ca.key -x509 -days 365 -out ca.crt
```

```bash [服务器]
# server.{crt,key} 服务器使用的证书和私钥
# 生成服务器私钥
openssl genrsa -out server.key 2048
# 生成服务器证书请求（CSR） 中间产物
openssl req -new -key server.key -out server.csr
# 使用[自签名CA证书和CA私钥]签署服务器证书
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365
```

```bash [客户端]
# client.{crt,key} 客户端使用的证书和私钥
# 生成客户端私钥
openssl genrsa -out client.key 2048
# 生成客户端证书请求（CSR） 中间产物
openssl req -new -key client.key -out client.csr
# 使用[自签名CA证书和CA私钥]签署客户端证书
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365
```

:::

## 命令行工具设置代理

::: code-group

```bash [terminal]
export ALL_PROXY=socks5://127.0.0.1:1080

export HTTP_PROXY=socks5://127.0.0.1:1080
export HTTPS_PROXY=socks5://127.0.0.1:1080
```

```cmd [cmd]
set ALL_PROXY=socks5://127.0.0.1:1080

set HTTP_PROXY=socks5://127.0.0.1:1080
set HTTPS_PROXY=socks5://127.0.0.1:1080
```

```ps1 [powershell]
$env:ALL_PROXY="socks5://127.0.0.1:1080"

$env:HTTP_PROXY="socks5://127.0.0.1:1080"
$env:HTTPS_PROXY="socks5://127.0.0.1:1080"
```

:::

::: tip 提示
近期发现上述设置无效，请使用下面这段 powershell 脚本

<<<@/assets/other/powershell/powershell-proxy-set-clear.ps1
:::
