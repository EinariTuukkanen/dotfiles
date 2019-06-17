#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add ~/.ssh/id_rsa
  ssh-add ~/.ssh/id_rsa_auron
fi

