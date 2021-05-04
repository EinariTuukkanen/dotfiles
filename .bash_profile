#
# ~/.bash_profile
#
PATH="$PATH:/root/.gem/ruby/2.7.0/bin"

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx
fi
