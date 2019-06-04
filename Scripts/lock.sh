#!/bin/sh

c0='#00000000' # clear
c1='#101012ff' # black
c2='#ffffffff' # white
c3='#975d5daa' # red
c4='#5d6197aa' # blue
c5='#c5a9f9aa' # theme light purple

i3lock \
--insidevercolor=$c0	\
--ringvercolor=$c4	\
--insidewrongcolor=$c0	\
--ringwrongcolor=$c3	\
--ignore-empty-password \
\
--insidecolor=$c0	\
--ringcolor=$c4		\
--separatorcolor=$c0	\
--linecolor=$c0		\
\
--timecolor=$c5		\
--datecolor=$c5		\
--keyhlcolor=$c5	\
--bshlcolor=$c5		\
\
--blur 10               \
--force-clock                 \
--indicator             \
--radius 25		\
--ring-width 3		\
--timestr="%H:%M"	\
--datestr="%A, %B %d."	\
\
--veriftext="Wait"			\
--wrongtext="F"			\
--timesize=40			\
--datesize=10			\
--indpos="100:h-100" \
--datepos="220:h-75" \
--timepos="220:h-90" \
--verifsize=20
# --time-font="Font Awesome 5 Free" \
# --date-font="Font Awesome 5 Free" \
# --layout-font="Font Awesome 5 Free" \
# --verif-font="Font Awesome 5 Free" \
# --wrong-font="Font Awesome 5 Free" \