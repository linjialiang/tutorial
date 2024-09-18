---
title: 安装 OWASP
titleTemplate: 渗透测试
---

# 安装 OWASP

## 必要环境

1. Unix 操作系统
2. git
3. Maven >= 3.2.3
4. OpenJDK

```bash
apt install git maven -y
```

## 安装 OpenJDK

从 [[清华源]](https://mirrors.tuna.tsinghua.edu.cn/Adoptium/) 可以下载到各个版本的 JDK

::: code-group

```bash [安装]
# JDK8
wget https://mirrors.tuna.tsinghua.edu.cn/Adoptium/8/jdk/x64/linux/OpenJDK8U-jdk_x64_linux_hotspot_8u422b05.tar.gz
# 官方未进行相关说明的补充
# 从 BenchmarkJava 1.2 测试版开始，引入了模块功能，请使用 JDK11 版本，因为 JDK8 不支持模块
wget https://mirrors.tuna.tsinghua.edu.cn/Adoptium/11/jdk/x64/linux/OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz

tar -xzf ./OpenJDK*.tar.gz
mv jdk-* /usr/lib/jdk-owasp
```

```bash [加入环境变量]
# ~/.bashrc

# jdk-owasp setting custom
export JAVA_HOME=/usr/lib/jdk-owasp
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

source ~/.bashrc
```

```bash [测试]
java -version
ldd /usr/lib/jdk-owasp/bin/java
```

:::

## 安装 OWASP

::: code-group

```bash [安装]
git clone https://github.com/OWASP-Benchmark/BenchmarkJava.git
# 推荐使用国内镜像
git clone https://e.coding.net/madnesslin/permeate/BenchmarkJava.git
# 进入目录
cd BenchmarkJava
# 清除之前构建结果并重新编译项目
mvn clear compile
# 本地访问 https://localhost:8443/benchmark/
chmod +x ./runBenchmark.sh
./runBenchmark.sh
# 远程访问 https://ip:8443/benchmark/
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

## mvn 配置国内镜像

文件 `/etc/maven/settings.xml` 内 `mirrors` 标签下 增加一个 `mirror` 子标签

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

::: tip 提示
2024/09/18 做过测试：官方镜像的速度非常快，仅当官方镜像速度慢或无法访问时，我们再去选择使用国内镜像
:::

## 开机自动运行靶场
