---
title: ffmpeg
titleTemplate: Debian 教程
---

# ffmpeg

ffmpeg 是一款功能强大的多媒体处理工具，可以用来进行各种格式的转换。

该工具使用终端指令来处理，适用于 Linux、Windows 等操作系统

## 安装

### Debian 安装

```bash
apt install ffmpeg -y
```

### Windows 安装

1. 去 https://github.com/BtbN/FFmpeg-Builds 下载最新版
2. 下载 GPL 开源协议版本 `ffmpeg-n6.0-latest-win64-gpl-6.0.zip`
3. 解压到指定目录，并将 bin 目录添加到环境变量 PATH 中

## 使用

::: code-group

```bash [格式转换]
# avi 转成 mp4
ffmpeg -i input.avi output.mp4
```

```batch [批量转换]
@echo off
set Ext=*.mkv,*.webm
set Path=E:\midea\倪海厦\人纪
set NewPath=E:\midea\倪海厦\media
echo ====== 开始转换 ======
for /r %Path% %%a in (%Ext%) do (
  echo 正在转换：%%a
  REM bat批处理文件外部程序使用绝对路径，设置到环境变量无效
  REM 启用自动加速转码
  C:\sf\ffmpeg\bin\ffmpeg.exe -hwaccel auto -i "%%a" -c:v h264_qsv "%NewPath%\%%~na.mp4"
  REM 启用英特尔核心显卡加速转码（源转码文件必须是h264）
  REM C:\sf\ffmpeg\bin\ffmpeg.exe -c:v h264_qsv -i "%%a" -c:v h264_qsv "%NewPath%\%%~na.mp4"
  REM 启用英特尔独立显卡(N卡)加速转码（源文件必须是h264）
  REM C:\sf\ffmpeg\bin\ffmpeg.exe -c:v h264_cuvid -i "%%a" -c:v h264_nvenc "%NewPath%\%%~na.mp4"
)
echo ====== 转换完成 ======
pause
```

:::
