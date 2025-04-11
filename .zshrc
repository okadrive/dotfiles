# Author: okapy
# Description: Zsh configuration file

# Encoding
export LANG=ja_JP.UTF-8

# PATH
export PATH="$HOME/.anyenv/bin:$PATH:/opt/homebrew/bin:/opt/homebrew/sbin:$GOROOT/bin:$GOPATH/bin:/Users/okapy/.anyenv/envs/pyenv/shims"

# anyenv
if [ -e "$HOME/.anyenv" ]; then
    eval "$(anyenv init -)"
fi

# hisoty setting
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト設定
ARCH=$(uname -m)
if [[ $ARCH == 'arm64' ]]; then
    PROMPT="%{${fg[cyan]}%}%n@%m%{${fg[magenta]}%}(arm)%{${reset_color}%}:%~
%{${fg[green]}%}$ %{${reset_color}%}"
    alias brew="PATH=/opt/homebrew/bin brew"
else
    PROMPT="%{${fg[cyan]}%}%n@%m%{${fg[magenta]}%}(x86)%{${reset_color}%}:%~
%{${fg[green]}%}$ %{${reset_color}%}"
    alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"
fi

# 補完設定
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# vcs_info
autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# オプション
setopt no_beep no_flow_control ignore_eof interactive_comments auto_cd auto_pushd \
       pushd_ignore_dups share_history hist_ignore_all_dups hist_ignore_space \
       hist_reduce_blanks extended_glob nonomatch

# peco settings
function peco-select-history() {
    local CMD=$(history -n 1 | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | sort -u | peco)
    [[ -n "$CMD" ]] && BUFFER="$CMD" && CURSOR=${#BUFFER}
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# alias
alias c='clear'
alias zr='vim ~/.zshrc'
alias sr='source ~/.zshrc'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias sudo='sudo '

# OS 別の設定
case ${OSTYPE} in
    darwin*) export CLICOLOR=1; alias ls='ls -G' ;;
    linux*) alias ls='ls --color=auto' ;;
esac