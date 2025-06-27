# alias
alias c='clear'
alias br='vim $HOME/.bashrc'
alias sbr='source $HOME/.bashrc'
alias bp='vim $HOME/.bash_profile'
alias bh='vim $HOME/.bash_history'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'

# ls
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias gcl='git clone'
alias gpl='git pull'

# color
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
    alias ll='ls -lG'
    alias la='ls -laG'
    export LSCOLORS=gxcxbEaEFxxEhEhBaDaCaD
fi

# read script
if [ -f $HOME/.config/git/git-completion.bash ]; then
    source $HOME/.config/git/git-completion.bash
fi
if [ -f $HOME/.config/git/git-prompt.sh ]; then
    source $HOME/.config/git/git-prompt.sh
fi

# show info at prompt
# if unstaged (not added file) change, show "*"
# if staged file but not committed, show "+"
GIT_PS1_SHOWDIRTYSTATE=true

# if current branch > upstream, show ">"
# if current branch < upstream, show "<"
GIT_PS1_SHOWUPSTREAM=true

# if untracked (not added new file), show "%"
GIT_PS1_SHOWUNTRACKEDFILES=true

# if stash, show "$"
GIT_PS1_SHOWSTASHSTATE=true

# change hostname color
PS1='\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[31m\]`__git_ps1`\n\[\033[01;32m\]\\$\[\033[00m\] '

export HISTCONTROL=ignoreboth:erasedups # 重複履歴を無視
HISTSIZE=5000 # history に記憶するコマンド数
HISTIGNORE="fg*:bg*:history*:h*" # history などの履歴を保存しない
HISTTIMEFORMAT='%Y.%m.%d %T' # history に時間を追加

# generate peco CMD for bash
# peco-history
function peco-history() {
    local CMD=$(fc -l -n 1 | cut -d' ' -f2- | sort | uniq | peco)
    READLINE_LINE=$CMD
    READLINE_POINT=${#CMD}
}

# bind peco CMD for bash
# peco-history
bind -x '"\C-r":peco-history'

#scp時、「bind: 警告: 行編集が有効になっていません」対策
if [ -z "$PS1" ]; then
  return;
fi

# peco-cd
function peco-cd() {
    local DIR=$(find . -mindepth 0 -maxdepth 1 -type d | peco)
    if [ -n "$DIR" ]; then
        cd "$DIR"
        echo "$PWD"
    fi
}

# bind peco-cd for bash
# peco-cd
bind -x '"\C-g":peco-cd'

# remove duplicate path
_path=""
for _p in $(echo $PATH | tr ':' ' '); do
  case ":${_path}:" in
    *:"${_p}":* )
      ;;
    * )
      if [ "$_path" ]; then
        _path="$_path:$_p"
      else
        _path=$_p
      fi
      ;;
  esac
done
PATH=$_path

unset _p
unset _path

