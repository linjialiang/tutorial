#!/usr/bin/env bash
printf "\033c"
echo_cyan(){
  printf '\033[1;36m%b\033[0m\n' "$@"
}
echo_green(){
  printf '\033[1;32m%b\033[0m\n' "$@"
}
echo_red(){
  printf '\033[1;31m%b\033[0m\n' "$@"
}
echo_yellow(){
  printf '\033[1;33m%b\033[0m\n' "$@"
}
echo_red "警告⚠️：请谨慎执行此脚本！！！"
echo_yellow "清理日志需停止服务，Postgres日志也会被删除，"
echo_cyan "请确认是否清理日志(1清理/默认不清理)："
read num
if [ $num -eq 1 ]; then
  systemctl stop {postgres,nginx,php83-fpm,redis}.service
  rm /server/logs/nginx/*
  rm /server/logs/php/*
  rm /server/logs/redis/*
  rm /server/logs/postgres/*.{json,log}
  rm /server/logs/postgres/wal_archive/*
  echo_cyan "是否启动服务(1启动/默认不启动)："
  read num2
  if [ $num2 -eq 1 ]; then
    systemctl start {postgres,nginx,php83-fpm,redis}.service
    echo_green "服务已重新启动"
  fi
  echo_green "清理完成"
fi
