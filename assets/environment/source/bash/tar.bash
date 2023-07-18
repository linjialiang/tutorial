#!/usr/bin/env bash

# tar.bash
echo "进入 /package 目录"

cd /package

for i in `ls *.tar.gz`;
do
    echo "gz解压" $i
    tar -xzf $i
done

for i in `ls *.tar.bz2`;
do
    echo "bz2解压" $i
    tar -xjf $i
done

for i in `ls *.tar.xz`;
do
    echo "xz解压" $i
    tar -xJf $i
done

echo "进入 php_ext 目录"

cd /package/php_ext

for i in `ls *.tgz`;
do
    echo "tgz解压" $i
    tar -xzf $i
done
