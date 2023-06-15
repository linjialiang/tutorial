# ~/.bashrc

# 结尾新增的内容
# MY_IP=`hostname -I`
# PS1='[${debian_chroot:+($debian_chroot)}\u@${MY_IP} \W]\$ ' 这是用户
PS1='[${debian_chroot:+($debian_chroot)}\u \W]\$ '

eval "`dircolors`"
export LS_OPTIONS='--color=auto'
alias ls="ls ${LS_OPTIONS} -F"
alias lsa="ls ${LS_OPTIONS} -aF"
alias ll="ls ${LS_OPTIONS} -lF"
alias lla="ls ${LS_OPTIONS} -laF"

alias bat='batcat'
alias cls='clear'

PATH=${PATH}:/usr/sbin:/usr/local/sbin:/usr/local/bin
PATH=${PATH}:/server/node/bin
PATH=${PATH}:/server/nginx/sbin:/server/sqlite3/bin:/server/redis/bin
PATH=${PATH}:/server/php/82/bin:/server/php/82/sbin
export PATH
