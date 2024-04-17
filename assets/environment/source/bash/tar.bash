#!/usr/bin/env bash

# 设定压缩文件根目录
TAR_DIR="/home/emad/environment/"
# 设置解压路径根目录
PACKAGE_DIR="/home/emad/package/"

if [ ! -d ${PACKAGE_DIR} ]; then
    mkdir -p "${PACKAGE_DIR}php_ext"
fi

# 进入压缩文件根目录
cd ${TAR_DIR}

for i in `ls *.tar.gz`;
do
    echo "gz解压" $i
    tar -xzf $i -C ${PACKAGE_DIR}
done

for i in `ls *.tar.bz2`;
do
    echo "bz2解压" $i
    tar -xjf $i -C ${PACKAGE_DIR}
done

for i in `ls *.tar.xz`;
do
    echo "xz解压" $i
    tar -xJf $i -C ${PACKAGE_DIR}
done

if [ -d "${TAR_DIR}php_ext" ]; then
    # 进入php_ext目录
    cd "${TAR_DIR}php_ext"

    EXT_DIR="${PACKAGE_DIR}php_ext"
    for i in `ls *.tgz`;
    do
        echo "tgz解压" $i
        tar -xzf $i -C ${EXT_DIR}
    done

    cd ${EXT_DIR}
    rm package.xml
fi
