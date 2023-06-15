
# ~/.zshrc

# 11行注释内容
# ZSH_THEME="robbyrussell"

# 77行修改的内容
plugins=(git z)

# 结尾新增的内容
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# MY_IP=`hostname -I`
# PROMPT="%(?:%{$fg_bold[green]%}%n@${MY_IP}➜ :%{$fg_bold[red]%}➜ )"
PROMPT="%(?:%{$fg_bold[green]%}%n@%m ➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
setopt no_nomatch

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
