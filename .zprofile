# System-wide environment variables
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# Homebrew
export PATH="/usr/local/sbin:$PATH"
if [[ $(uname -m) == "arm64" ]]; then
    # Apple Silicon Mac
    export PATH="/opt/homebrew/bin:$PATH"
    export HOMEBREW_PREFIX="/opt/homebrew"
else
    # Intel Mac
    export PATH="/usr/local/bin:$PATH"
    export HOMEBREW_PREFIX="/usr/local"
fi

# anyenv (Multi-language environment manager)
export PATH="$HOME/.anyenv/bin:$PATH"
[ -e "$HOME/.anyenv" ] && eval "$(anyenv init -)"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Remove duplicates from PATH
typeset -U path PATH

# macOS specific settings
if [[ "$OSTYPE" == darwin* ]]; then
    export CLICOLOR=1
    export LSCOLORS=gxcxbEaEFxxEhEhBaDaCaD
fi

# Color settings
export LS_COLORS="di=36:ln=32:so=31;1;44:pi=30;1;44:ex=1;35:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=30;1;43:tw=30;1;42:ow=30;1;43"
