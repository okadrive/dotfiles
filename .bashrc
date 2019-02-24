alias c='clear'
alias la='ls -a'
alias br='vim ~/.bashrc'
alias sbr='source ~/.bashrc'
alias bp='vim ~/.bash_profile'
alias bh='vim ~/.bash_history'
alias mysql='mysql -u root -proot'
alias rm='rm -i'

PATH=$HOME/bin:$PATH
export PATH

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
     alias ls='ls --color=auto'
   else
     alias ls='ls -G'
     alias ll='ls -lG'
     alias la='ls -laG'
     export LSCOLORS=gxcxbEaEFxxEhEhBaDaCaD
   fi

# read script
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

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
PS1='\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\n\[\033[31m\]$(__git_ps1)\[\033[01;32m\]\\$\[\033[00m\] '
