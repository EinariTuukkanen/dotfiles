#!/bin/bash

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Merge in defaults and keymaps
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Execute profile
# [[ -f ~/.profile ]] && . ~/.profile

# Set keyboard and mouse options
setxkbmap -layout fi -option "nbsp:none"
xsetroot -cursor_name left_ptr

# Start relevant applications
sxhkd &
flameshot &
dunst &
fusuma -c /home/einari/.config/fusuma/config.yml &
lxpolkit &
# exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# xautolock -time 5 -locker "/home/einari/.config/scripts/lock.sh" -notify 30 -notifier "notify-send 'Locking in 30 seconds.' -t 5000" &
exec bspwm
