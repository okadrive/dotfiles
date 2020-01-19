#PS1="[\t \u:\w]$"
source ~/.bashrc

# read .bashrc in Mac OS
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH=/usr/local/Cellar/openssl@1.1/1.1.1d/bin:$PATH
eval "$(anyenv init -)"

