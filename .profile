export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nano
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/chromium
#export SSH_ASKPASS=/usr/bin/qt4-ssh-askpass
export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass

# run ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add $HOME/.ssh/id_rsa &
  ssh-add $HOME/.ssh/id_rsa_auron &
fi

