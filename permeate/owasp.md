---
title: OWASP Benchmark
titleTemplate: 渗透测试
---

# OWASP Benchmark

`OWASP Benchmark Project` 是一个 Java 测试套件，旨在评估自动化软件漏洞检测工具的准确性，覆盖率和速度。如果没有能力衡量这些工具，就很难了解它们的长处和短处，并将它们相互比较。

`OWASP Benchmark` 是一个完全可运行的开源 Web 应用程序，包含数千个可利用的测试用例，每个用例都映射到特定的 CWE，可以通过任何类型的应用程序安全测试（AST）工具进行分析，包括 SAST，DAST（如 ZAP）和 IAST 工具。其目的是，所有的漏洞故意包括在基准和评分实际上是可利用的，所以它是一个公平的测试任何类型的应用程序漏洞检测工具。Benchmark 还包括许多开源和商业 AST 工具的记分卡生成器，并且支持的工具集一直在增长。

总结：`OWASP Benchmark Project` 是一个项目计划，而 `OWASP Benchmark` 是 OWASP 官方推出的标准化 Web 应用安全测试应用程序！

## 测试服务器

```
发行版 Debian GNU/Linux 12 (bookworm)
内核 6.1.0-39-amd64
```

## 你能用 Benchmark 做什么？

1. 编译 Benchmark 项目中的所有软件（例如，mvn compile）

2. 针对基准测试用例代码运行静态漏洞分析工具（SAST）

3. 使用动态应用程序安全测试工具（DAST）扫描正在运行的 Benchmark 版本

    - 下面提供了如何运行它的说明

4. 为您有结果的每个工具生成记分卡

    - 有关 Benchmark 支持生成记分卡的工具列表，请参阅工具支持/结果页面

## 安装流程

### 1. 必要条件

1. Linux/Unix 操作系统
2. git
3. Maven >= 3.2.3
4. OpenJDK

### 2. 安装依赖

#### 安装 apt 依赖

```bash
apt install git maven default-jdk -y
```

#### 安装特定版本的 OpenJDK

::: warning :warning:使用说明
2025-09-04 本次使用 debian12 测试，apt 自带的 jdk 即可编译成功
:::

从 [[清华源]](https://mirrors.tuna.tsinghua.edu.cn/Adoptium/) 可以下载到各个版本的 JDK

::: code-group

```bash [安装]
# JDK8
wget https://mirrors.tuna.tsinghua.edu.cn/Adoptium/8/jdk/x64/linux/

# JDK11
# 从 BenchmarkJava 1.2 测试版开始，引入了模块功能，请使用 JDK11 版本，因为 JDK8 不支持模块
wget https://mirrors.tuna.tsinghua.edu.cn/Adoptium/11/jdk/x64/linux/

# 解压并移动位置
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

### 3. 下载并安装

下载 BenchmarkJava 源码并执行安装

```bash
su - www -s /bin/zsh
git clone https://gitee.com/linjialiang/BenchmarkJava.git
# 进入目录
cd BenchmarkJava
# 清除之前构建结果并重新编译项目
mvn clean compile
```

## 使用入门

::: code-group

```bash [前台启动]
# 前台启动-终端断开连接就会停止
# 本地访问 https://localhost:8443/benchmark/
chmod +x ./runBenchmark.sh
./runBenchmark.sh
# 远程访问 https://ip:8443/benchmark/
chmod +x ./runRemoteAccessibleBenchmark.sh
./runRemoteAccessibleBenchmark.sh
```

```bash [后台启动]
# 后台启动-只有服务进程被中断，才会停止
# 输出到 /tmp/owasp.log 文件
nohup ./runRemoteAccessibleBenchmark.sh > /tmp/owasp.log &
# 内容不输出
nohup ./runRemoteAccessibleBenchmark.sh > /dev/null 2>&1 &
# 查看
ps -ef|grep BenchmarkJava
```

:::

::: warning ⚠️ 注意：
需要先在 `前台执行` 一遍脚本后，才能在后台启动脚本，否则会启动失败
:::

## 绑定域名

通常需要走代理转发的方式才能绑定域名，这里以 nginx 为例

::: code-group

```bash [安装 Nginx]
apt install nginx -y
```

```ini [Nginx 代理转发]
# /etc/nginx/sites-available/owasp-benchmark

server {
    listen 80;
    # 替换为你的域名或IP
    server_name benchmark.your-domain.com;

    # 代理配置
    location / {
        # 转发到 OWASP Benchmark 的 8443 端口，支持本地和远程地址
        proxy_pass https://127.0.0.1:8443/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 443 ssl;
    # 替换为你的域名或IP
    server_name benchmark.your-domain.com;

    # SSL 证书路径（需替换为实际路径）
    ssl_certificate /etc/letsencrypt/live/benchmark.your-domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/benchmark.your-domain.com/privkey.pem;

    # 代理配置
    location / {
        # 转发到 OWASP Benchmark 的 8443 端口，支持本地和远程地址
        proxy_pass https://127.0.0.1:8443/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash [启用配置并测试]
ln -s /etc/nginx/sites-available/owasp-benchmark /etc/nginx/sites-enabled/
# 检查配置语法
nginx -t
systemctl reload nginx
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

::: tip 测试结果

1. 当官方镜像速度慢或无法访问时，我们可以去选择使用国内镜像。

:::

## 开机自动运行靶场
