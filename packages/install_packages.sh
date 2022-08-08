#!/bin/bash

installable_packages=$(comm -12 <(pacman -Slq | sort) <(sort packages.txt))
sudo pacman -S --needed $installable_packages
