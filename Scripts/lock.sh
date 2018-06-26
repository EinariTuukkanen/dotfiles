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
\
--insidecolor=$c0	\
--ringcolor=$c0		\
--separatorcolor=$c0	\
--linecolor=$c0		\
\
--timecolor=$c5		\
--datecolor=$c5		\
--keyhlcolor=$c5	\
--bshlcolor=$c5		\
\
--blur 5                \
--clock                 \
--indicator             \
--radius 180		\
--ring-width 10		\
--timestr="%H:%M"	\
--datestr="%A, %B %d."	\
\
--veriftext=""			\
--wrongtext=""			\
--timesize=80			\
--datesize=20			\


