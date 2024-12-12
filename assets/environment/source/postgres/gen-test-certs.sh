#!/bin/bash

# 这些文件是用于生成测试证书的，部署环境应从正规的数字证书的签发机构获取相关证书
#
#   tls/ca.{crt,key}          CA证书用于签署其他证书，以建立信任链
#   tls/pgsql.{crt,key}       这个证书可以用于任何用途，因为它没有任何特定的使用限制
#   tls/client.{crt,key}      只能用于SSL/TLS连接中的客户端身份验证
#   tls/server.{crt,key}      只能用于SSL/TLS连接中的服务器身份验证
#   tls/pgsql.dh              Diffie-Hellman 参数文件 (用于在SSL/TLS握手过程中协商临时密钥，以确保通信的安全性)

generate_cert() {
    local name=$1
    local cn="$2"
    local opts="$3"

    local keyfile=tls/${name}.key
    local certfile=tls/${name}.crt

    [ -f $keyfile ] || openssl genrsa -out $keyfile 2048
    openssl req \
        -new -sha256 \
        -subj "/O=Redis Test/CN=$cn" \
        -key $keyfile | \
        openssl x509 \
            -req -sha256 \
            -CA tls/ca.crt \
            -CAkey tls/ca.key \
            -CAserial tls/ca.txt \
            -CAcreateserial \
            -days 365 \
            $opts \
            -out $certfile
}

mkdir tls
[ -f tls/ca.key ] || openssl genrsa -out tls/ca.key 4096
openssl req \
    -x509 -new -nodes -sha256 \
    -key tls/ca.key \
    -days 3650 \
    -subj '/O=Redis Test/CN=Certificate Authority' \
    -out tls/ca.crt

cat > tls/openssl.cnf <<_END_
[ server_cert ]
keyUsage = digitalSignature, keyEncipherment
nsCertType = server

[ client_cert ]
keyUsage = digitalSignature, keyEncipherment
nsCertType = client
_END_

generate_cert server "Server-only" "-extfile tls/openssl.cnf -extensions server_cert"
generate_cert client "Client-only" "-extfile tls/openssl.cnf -extensions client_cert"
generate_cert redis "Generic-cert"

[ -f tls/redis.dh ] || openssl dhparam -out tls/redis.dh 2048
