alias c='clear'
alias la='ls -a'
alias br='vim ~/.bashrc'
alias sbr='source ~/.bashrc'
alias bp='vim ~/.bash_profile'
alias bh='vim ~/.bash_history'
alias mysql='mysql -u root -proot'
alias rm='rm -i'

function gtest() {
  g++-9 ./main_test.cpp
  ./a.out
}
alias gtest=gtest


#PATH=$HOME/bin:$PATH
#export PATH
GOPATH=$HOME/go
#export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:$HOME/bin:$GOPATH/bin:$GOPATH/1.13.0/bin/

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
PS1='\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[31m\]$(__git_ps1)\n\[\033[01;32m\]\\$\[\033[00m\] '

export HISTCONTROL=ignoreboth:erasedups # 重複履歴を無視
HISTSIZE=5000 # history に記憶するコマンド数
HISTIGNORE="fg*:bg*:history*:h*" # history などの履歴を保存しない
HISTTIMEFORMAT='%Y.%m.%d %T' # history に時間を追加

# peco for bash
peco-history() {
  local NUM=$(history | wc -l)
  local FIRST=$((-1*(NUM-1)))

  if [ $FIRST -eq 0 ] ; then
    # Remove the last entry, "peco-history"
    history -d $((HISTCMD-1))
    echo "No history" >&2
    return
  fi

  local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

  if [ -n "$CMD" ] ; then
    # Replace the last entry, "peco-history", with $CMD
    history -s $CMD

    if type osascript > /dev/null 2>&1 ; then
      # Send UP keystroke to console
      (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
    fi

    # Uncomment below to execute it here directly
    # echo $CMD >&2
    # eval $CMD
  else
    # Remove the last entry, "peco-history"
    history -d $((HISTCMD-1))
  fi
}

bind '"\C-r":"peco-history\n"'
bind '"\C-xr": reverse-search-history'

# ssh with using peco for bash
peco-ssh() {
  local HOST=$(grep 'host ' ~/.ssh/config | awk '{print $2}' | peco)
  if [ -n "$HOST" ]; then
  echo "ssh -F ~/.ssh/config $HOST"
          ssh -F ~/.ssh/config $HOST
  fi
}

alias s="peco-ssh"
#bind '"\C-s":"peco-ssh\n"'

peco-connectwifi() {
  # SSID 名を取得
  local SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport --scan | sed '1d' | awk '{print $1}' | sort -n | uniq | peco)
  if [ -n "$SSID" ]; then
    # SSID に接続 (sudo パスワードと，設定されている場合は Wi-Fi パスワードが聞かれる)
    echo "sudo networksetup -setairportnetwork en0 $SSID"
    sudo networksetup -setairportnetwork en0 $SSID
  fi
}

alias cw="peco-connectwifi"

peco-cd() {
  local sw="1"
  while [ "$sw" != "0" ]
   do
		if [ "$sw" = "1" ];then
			local list=$(echo -e "---$PWD\n../\n$( ls -F | grep / )\n---Show hidden directory\n---Show files, $(echo $(ls -F | grep -v / ))\n---HOME DIRECTORY")
		elif [ "$sw" = "2" ];then
			local list=$(echo -e "---$PWD\n$( ls -a -F | grep / | sed 1d )\n---Hide hidden directory\n---Show files, $(echo $(ls -F | grep -v / ))\n---HOME DIRECTORY")
		else
			local list=$(echo -e "---BACK\n$( ls -F | grep -v / )")
		fi

		local slct=$(echo -e "$list" | peco )

		if [ "$slct" = "---$PWD" ];then
			local sw="0"
		elif [ "$slct" = "---Hide hidden directory" ];then
			local sw="1"
		elif [ "$slct" = "---Show hidden directory" ];then
			local sw="2"
		elif [ "$slct" = "---Show files, $(echo $(ls -F | grep -v / ))" ];then
			local sw=$(($sw+2))
		elif [ "$slct" = "---HOME DIRECTORY" ];then
			cd "$HOME"
		elif [[ "$slct" =~ / ]];then
			cd "$slct"
		elif [ "$slct" = "" ];then
			:
		else
			local sw=$(($sw-2))
		fi
   done
}
alias sd='peco-cd'
