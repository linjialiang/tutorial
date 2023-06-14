#!/bin/bash

# tar.bash
echo "进入 package 目录"

cd /package/

for i in `ls *.tar.gz`;
do
    echo "删除" $i
    rm $i
done

for i in `ls *.tar.bz2`;
do
    echo "删除" $i
    rm $i
done

for i in `ls *.tar.xz`;
do
    echo "删除" $i
    rm $i
done

echo "进入 default 目录"

cd /package/default/

for i in `ls *.tar.gz`;
do
    echo "删除" $i
    rm $i
done

for i in `ls *.tar.bz2`;
do
    echo "删除" $i
    rm $i
done

for i in `ls *.tar.xz`;
do
    echo "删除" $i
    rm $i
done

echo "进入 php_ext 目录"

cd /package/php_ext/

for i in `ls *.tgz`;
do
    echo "删除" $i
    rm $i
done

for i in `ls *.xml`;
do
    echo "删除" $i
    rm $i
done
