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

去[[Java 官网]](https://www.oracle.com/java/technologies/downloads/)可以下载到最新的Java8—— [[dk-8u391-linux-x64.tar.gz]](https://download.oracle.com/otn/java/jdk/8u391-b13/b291ca3e0c8548b5a51d5a5f50063037/jdk-8u391-linux-x64.tar.gz)

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
# 构建前 mvn 建议设为阿里云镜像
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
# 输出到 /tmp/owasp.log 文件
nohup ./runRemoteAccessibleBenchmark.sh > /tmp/owasp.log &
# 内容不输出
nohup ./runRemoteAccessibleBenchmark.sh > /dev/null 2>&1 &
# 查看
ps -ef|grep BenchmarkJava
```

:::

## 配置国内镜像

文件 `/etc/maven/setting.xml` 内 `mirrors` 标签下 增加一个 `mirror` 子标签

```xml
<mirrors>
  <!-- 阿里仓库 -->
  <mirror>
    <id>aliyunmaven</id>
    <mirrorOf>*</mirrorOf>
    <name>阿里云公共仓库</name>
    <url>https://maven.aliyun.com/repository/public</url>
  </mirror>
</mirrors>
```
