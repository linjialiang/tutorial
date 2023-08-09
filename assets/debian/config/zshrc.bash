# ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"
plugins=(git z)
source $ZSH/oh-my-zsh.sh
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# PROMPT="%(?:%{$fg_bold[green]%}%n@%m ➜ :%{$fg_bold[red]%}➜ )"
PROMPT="%(?:%{$fg_bold[green]%}%n ➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
alias bat='batcat'
alias cls='clear'
setopt no_nomatch
eval "`dircolors`"
export LS_OPTIONS='--color=auto'
alias ls="ls ${LS_OPTIONS} -F"
alias lsa="ls ${LS_OPTIONS} -aF"
alias ll="ls ${LS_OPTIONS} -lF"
alias lla="ls ${LS_OPTIONS} -laF"
# 使用 echo $PATH 查询，将需要的路径写入
PATH=${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export PATH
