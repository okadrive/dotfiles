# システム全体の環境変数設定
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# anyenv (多言語環境管理)
export PATH="$HOME/.anyenv/bin:$PATH"
[ -e "$HOME/.anyenv" ] && eval "$(anyenv init -)"

# ローカルバイナリ
export PATH="$HOME/.local/bin:$PATH"

# PATH重複除去
typeset -U path PATH

# macOS特有の設定
if [[ "$OSTYPE" == darwin* ]]; then
    export CLICOLOR=1
    export LSCOLORS=gxcxbEaEFxxEhEhBaDaCaD
fi

# 色設定
export LS_COLORS="di=36:ln=32:so=31;1;44:pi=30;1;44:ex=1;35:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=30;1;43:tw=30;1;42:ow=30;1;43"
