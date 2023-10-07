---
title: 安装 OWASP
titleTemplate: 渗透测试
---

# 安装 OWASP

## 必要环境

1. Unix 操作系统
2. git
3. Maven >= 3.2.3
4. Java 8

```bash
apt install git maven -y
```

## 安装 Java 8

去[[Java 官网]](https://www.oracle.com/java/technologies/downloads/)可以下载到最新的Java8—— [[jdk-8u381-linux-x64.tar.gz]](https://download.oracle.com/otn/java/jdk/8u381-b09/8c876547113c4e4aab3c868e9e0ec572/jdk-8u381-linux-x64.tar.gz)

::: code-group

```bash [安装]
tar -xzf ./jdk-8u381-linux-x64.tar.gz
mv jdk-8u381-linux-x64 /usr/lib/jdk8
```

```bash [加入环境变量]
# ~/.bashrc

# jdk8 setting custom
export JAVA_HOME=/usr/lib/jdk8
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

source ~/.bashrc
```

```bash [测试]
java -version
ldd /usr/lib/jdk8/bin/java
```

:::

## 安装 OWASP

::: code-group

```bash [安装]
git clone https://github.com/OWASP-Benchmark/BenchmarkJava.git
cd BenchmarkJava
# 构建
mvn compile
# 本地访问 localhost:8443/benchmark/
chmod +x ./runBenchmark.sh
./runBenchmark.sh
# 远程访问 ip:8443/benchmark/
chmod +x ./runRemoteAccessibleBenchmark.sh
./runRemoteAccessibleBenchmark.sh
```

```bash [后台启动]
nohup ./runRemoteAccessibleBenchmark.sh >/tmp/owasp.log &
```

:::
