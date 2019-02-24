#PS1="[\t \u:\w]$"
source ~/.bashrc
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH

# read .bashrc in Mac OS
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi
