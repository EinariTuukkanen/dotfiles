#!/bin/bash
mkdir ~/.config/i3/
ln -s $HOME/dotfiles/config/i3/config ~/.config/i3/config
ln -s $HOME/dotfiles/config/i3/default_wallpaper.jpg ~/.config/i3/default_wallpaper.jpg

mkdir ~/.config/polybar/
ln -s $HOME/dotfiles/config/polybar/config ~/.config/polybar/config
ln -s $HOME/dotfiles/config/polybar/launch.sh ~/.config/polybar/launch.sh
