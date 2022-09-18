# 環境変数
export LANG=ja_JP.UTF-8

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# golang
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# python
export PATH="/Users/okapy/.anyenv/envs/pyenv/shims:$PATH"

# M1 Mac
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# lima for Docker
export DOCKER_HOST=unix:///${HOME}/.lima/docker/sock/docker.sock

# wasi-sdk
#export PATH="/opt/wasi-sdk:$PATH"

# erace duplicate path
typeset -U PATH

# C++ shortcut
g() {
    g++ main.cpp -mmacosx-version-min=12.4
}

gt() {
    g++ ./main_test.cpp -mmacosx-version-min=12.4
    ./a.out
}

# 色を使用出来るようにする
autoload -Uz colors
colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
    alias ll='ls -lG'
    alias la='ls -laG'
    export LSCOLORS=gxcxbEaEFxxEhEhBaDaCaD
    export LS_COLORS="di=36:ln=32:so=31;1;44:pi=30;1;44:ex=1;35:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=30;1;43:tw=30;1;42:ow=30;1;43"
fi

# emacs 風キーバインドにする
#bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
ARCH=`uname -m`
# 2行表示
if [[ $ARCH == 'arm64' ]]; then
    PROMPT="%{${fg[cyan]}%}%n@%m%{${fg[magenta]}%}(arm)%{${reset_color}%}:%~
%{${fg[green]}%}$ %{${reset_color}%}"
    alias brew="PATH=/opt/homebrew/bin brew"
else
    PROMPT="%{${fg[cyan]}%}%n@%m%{${fg[magenta]}%}(x86)%{${reset_color}%}:%~
%{${fg[green]}%}$ %{${reset_color}%}"
    alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"
fi

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# zshの補完候補にls --colorsと同じ色をつける
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # 補完候補のカラー表示

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# ワイルドカード(*)で補完がかからないようにする
setopt nonomatch

# peco settings
# 過去に実行したコマンドを選択しctrl-rにバインド
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-cd() {
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
    zle clear-screen
}
zle -N peco-cd
bindkey '^w' peco-cd

function peco-ssh() {
  local selected_host=$(awk '
  tolower($1)=="host" {
    for (i=2; i<=NF; i++) {
      if ($i !~ "[*?]") {
        print $i
      }
    }
  }
  ' ~/.ssh/config | sort | peco --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ssh
bindkey '^s' peco-ssh

# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# custom alias
alias zr='vim ~/.zshrc'
alias sr='source ~/.zshrc'
alias gs='git status'
alias c='clear'
alias dsstore='find . -name 'a.out' -type f -ls -delete'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls --color=auto'
        ;;
esac

# vim:set ft=zsh:

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/okapy/.anyenv/envs/pyenv/versions/miniforge3-4.9.2/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/okapy/.anyenv/envs/pyenv/versions/miniforge3-4.9.2/etc/profile.d/conda.sh" ]; then
        . "/Users/okapy/.anyenv/envs/pyenv/versions/miniforge3-4.9.2/etc/profile.d/conda.sh"
    else
        export PATH="/Users/okapy/.anyenv/envs/pyenv/versions/miniforge3-4.9.2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
