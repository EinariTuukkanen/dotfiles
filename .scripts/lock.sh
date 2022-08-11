#!/usr/bin/env bash

i3lock \
--clock --ignore-empty-password  \
--lockfailed-text '' --lock-text '' --noinput-text '' --wrong-text '' --verif-text '' \
--color 161014 --line-color c15653 \
--indicator --radius 40 --ring-width 3 \
--inside-color 161014 --ring-color 321c1e \
--keyhl-color 81cdd3 --bshl-color ff6666 \
--ringver-color 81cdd3 --insidever-color 321c1e \
--ringwrong-color c15653 --insidewrong-color 321c1e \
--ind-pos 'x+90:y+h-90' \
--time-pos 'x+220:y+h-90' --date-pos 'x+215:y+h-70' \
--time-str '%H:%M:%S' --date-str '%A, %m %Y' \
--time-align left --date-align left \
--time-color c15653 --date-color c15653 \
--time-font "Roboto:style=Normal"
