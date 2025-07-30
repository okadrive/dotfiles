# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Prompt settings
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

# Color settings
autoload -Uz colors && colors
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi

# Completion settings
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# Option settings
setopt no_beep no_flow_control ignore_eof interactive_comments auto_cd auto_pushd \
    pushd_ignore_dups share_history hist_ignore_all_dups hist_ignore_space \
    hist_reduce_blanks extended_glob nonomatch

# Peco history search
function peco-select-history() {
    local CMD=$(history -n 1 | LANG=C sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | sort -u | peco)
    [[ -n "$CMD" ]] && BUFFER="$CMD" && CURSOR=${#BUFFER}
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# Aliases
alias c='clear'
alias zr='vim ~/.zshrc'
alias sr='source ~/.zshrc'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias sudo='sudo '

# Global aliases
alias -g L='| less'
alias -g G='| grep'
if which pbcopy >/dev/null 2>&1; then
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1; then
    alias -g C='| xsel --input --clipboard'
fi

# OS-specific settings
case ${OSTYPE} in
    linux*) alias ls='ls --color=auto' ;;
esac