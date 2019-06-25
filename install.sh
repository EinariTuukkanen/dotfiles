#!/bin/bash
mkdir -p $HOME/.config/i3/
ln -s $HOME/dotfiles/config/i3/config $HOME/.config/i3/config
ln -s $HOME/dotfiles/config/i3/default_wallpaper.jpg $HOME/.config/i3/default_wallpaper.jpg

mkdir -p $HOME/.config/polybar/
ln -s $HOME/dotfiles/config/polybar/config $HOME/.config/polybar/config
ln -s $HOME/dotfiles/config/polybar/launch.sh $HOME/.config/polybar/launch.sh

mkdir -p $HOME/.config/rofi/
ln -s $HOME/dotfiles/config/rofi/config $HOME/.config/rofi/config
ln -s $HOME/dotfiles/config/rofi/custom-dmenu.rasi $HOME/.config/rofi/custom-dmenu.rasi

mkdir -p $HOME/.config/compton/compton.conf
ln -s $HOME/dotfiles/config/compton/compton.conf $HOME/.config/compton/compton.conf

ln -s $HOME/dotfiles/.Xresources $HOME/.Xresources
ln -s $HOME/dotfiles/.profile $HOME/.profile
ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/.bash_profile $HOME/.bash_profile

mkdir -p $HOME/.config/Code - OSS/User
ln -s "$HOME/dotfiles/config/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
ln -s "$HOME/dotfiles/config/Code - OSS/User/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"

ln -s $HOME/dotfiles/.xcolors $HOME/.xcolors