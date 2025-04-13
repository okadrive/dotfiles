# 環境変数
export LANG=ja_JP.UTF-8
export PATH="$HOME/.anyenv/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$GOROOT/bin:$GOPATH/bin:/Users/okapy/.anyenv/envs/pyenv/shims:$PATH"

# anyenv
[ -e "$HOME/.anyenv" ] && eval "$(anyenv init -)"

# ヒストリ設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト設定
ARCH=$(uname -m)
PROMPT="%F{cyan}%n@%m%f%F{magenta}(${ARCH})%f:%~%F{green}
$ %f"

# vcs_info
autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats "[%b|%a]"
function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

# 色設定
autoload -Uz colors && colors
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
    export LSCOLORS=gxcxbEaEFxxEhEhBaDaCaD
    export LS_COLORS="di=36:ln=32:so=31;1;44:pi=30;1;44:ex=1;35:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=30;1;43:tw=30;1;42:ow=30;1;43"
fi

# 補完設定
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# オプション設定
setopt no_beep no_flow_control ignore_eof interactive_comments auto_cd auto_pushd \
    pushd_ignore_dups share_history hist_ignore_all_dups hist_ignore_space \
    hist_reduce_blanks extended_glob nonomatch

# peco ヒストリ検索
function peco-select-history() {
    local CMD=$(history -n 1 | LANG=C sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | sort -u | peco)
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

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
if which pbcopy >/dev/null 2>&1; then
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1; then
    alias -g C='| xsel --input --clipboard'
fi

# OS 別設定
case ${OSTYPE} in
    darwin*) export CLICOLOR=1; alias ls='ls -G' ;;
    linux*) alias ls='ls --color=auto' ;;
esac