#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

GREEN="\[\e[0;32m\]"
BGREEN="\[\e[01;32m\]"
BLUE="\[\e[0;34m\]"
BBLUE="\[\e[01;34m\]"
RED="\[\e[0;31m\]"
BRED="\[\e[1;31m\]"
YELLOW="\[\e[0;33m\]"
BYELLOW="\[\e[01;33m\]"
WHITE="\[\e[0;37m\]"
BWHITE="\[\e[1;37m\]"
COLOREND="\[\e[00m\]"

parse_git_branch() {
    line=$(git status 2> /dev/null | head -n1)
    branch=${line##* }

    if [[ $branch != "" ]]; then
        if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working tree clean" ]]; then
            echo " ${WHITE}$branch${COLOREND}"
        else
            echo " ${RED}$branch${COLOREND}"
        fi
    fi
}

working_directory() {
    dir=`pwd`
    in_home=0

    if [[ `pwd` =~ ^"$HOME"(/|$) ]]; then
        dir="~${dir#$HOME}"
        in_home=1
    fi

    # workingdir=""
    # if [[ `tput cols` -lt 110 ]]; then
    #     first="/`echo $dir | cut -d / -f 2`"
    #     letter=${first:0:2}
    #     if [[ $in_home == 1 ]]; then
    #         letter="~$letter"
    #     fi

    #     proj=`echo $dir | cut -d / -f 3`
    #     beginning="$letter/$proj"
    #     end=`echo "$dir" | rev | cut -d / -f1 | rev`

    #     if [[ $proj == "" ]]; then
    #         workingdir="$dir"
    #     elif [[ $proj == "~" ]]; then
    #         workingdir="$dir"
    #     elif [[ $dir =~ "$first/$proj"$ ]]; then
    #         workingdir="$beginning"
    #     elif [[ $dir =~ "$first/$proj/$end"$ ]]; then
    #         workingdir="$beginning/$end"
    #     else
    #         workingdir="$beginning/…/$end"
    #     fi
    # else
    end=`echo "$dir" | rev | cut -d / -f1 | rev`
    workingdir="$end"
    # workingdir="$dir"
    # fi

    echo -e "${BBLUE}$workingdir${COLOREND}"
}

parse_remote_state() {
    remote_state=$(git status -sb 2> /dev/null | grep -oh "\[.*\]")
    if [[ "$remote_state" != "" ]]; then
        out="${BBLUE}[${COLOREND}"

        if [[ "$remote_state" == *ahead* ]] && [[ "$remote_state" == *behind* ]]; then
            behind_num=$(echo "$remote_state" | grep -oh "behind [0-9]*" | grep -oh "[0-9]*$")
            ahead_num=$(echo "$remote_state" | grep -oh "ahead [0-9]*" | grep -oh "[0-9]*$")
            out="$out${RED}$behind_num${COLOREND},${GREEN}$ahead_num${COLOREND}"
        elif [[ "$remote_state" == *ahead* ]]; then
            ahead_num=$(echo "$remote_state" | grep -oh "ahead [0-9]*" | grep -oh "[0-9]*$")
            out="$out${GREEN}$ahead_num${COLOREND}"
        elif [[ "$remote_state" == *behind* ]]; then
            behind_num=$(echo "$remote_state" | grep -oh "behind [0-9]*" | grep -oh "[0-9]*$")
            out="$out${RED}$behind_num${COLOREND}"
        fi

        out="$out${BBLUE}]${COLOREND}"
        echo " $out"
    fi
}

parse_stash_state() {
    stash_count=$(set -o pipefail && git stash list 2> /dev/null | wc -l)
    if [[ $? -eq 0 ]]; then
        if [[ "$stash_count" == "0" ]]; then
            echo "${BLUE}(0)${COLOREND}"
        else
            echo "${RED}(${stash_count})${COLOREND}"
        fi
    fi
}

prompt() {
    if [[ $? -eq 0 ]]; then
        exit_status="${BWHITE}▸${COLOREND} "
    else
        exit_status="${BRED}▸${COLOREND} "
    fi
    history -a
    history -n
    PS1="${BBLUE}[$(working_directory)$(parse_git_branch)${BBLUE}]$(parse_remote_state) $exit_status"
    # PS1="$(working_directory)$(parse_git_branch)$(parse_remote_state)$(parse_stash_state) $exit_status"
}

PROMPT_COMMAND=prompt

# Colorful ls
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
eval $(dircolors -b ~/.dir_colors)
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
unset match_lhs

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

ssh-proxy() {
    # $1 = localhost port
	ssh -R 80:localhost:$1 serveo.net
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export PATH="/home/einari/taito-cli/bin:$PATH"
source /home/einari/taito-cli/support/bash/complete.sh

# Old stuff

# Change the window title of X terminals
# case ${TERM} in
# 	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
# 		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
# 		;;
# 	screen*)
# 		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
# 		;;
# esac

# use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
# safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
# match_lhs=""
# [[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
# [[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
# [[ -z ${match_lhs}    ]] \
# 	&& type -P dircolors >/dev/null \
# 	&& match_lhs=$(dircolors --print-database)
# [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

# if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	# if type -P dircolors >/dev/null ; then
		# if [[ -f ~/.dir_colors ]] ; then
# eval $(dircolors -b ~/.dir_colors)
	# 	elif [[ -f /etc/DIR_COLORS ]] ; then
	# 		eval $(dircolors -b /etc/DIR_COLORS)
	# 	fi
	# fi

# 	if [[ ${EUID} == 0 ]] ; then
# 		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
# 	else
# 		# PS1='\[\033[01;36m\][\u@\h\[\033[01;37m\] \W\[\033[01;36m\]]\033[00m '
# 		PS1='\[\033[01;31m\][\u@\h\[\033[01;37m\] \W\[\033[01;31m\]]\$\[\033[00;00m\] '
# 	fi

	# alias ls='ls --color=auto'
	# alias grep='grep --colour=auto'
	# alias egrep='egrep --colour=auto'
	# alias fgrep='fgrep --colour=auto'
# else
# 	if [[ ${EUID} == 0 ]] ; then
# 		# show root@ when we don't have colors
# 		PS1='\u@\h \W \$ '
# 	else
# 		PS1='\u@\h \w \$ '
# 	fi
# fi
# unset use_color safe_term match_lhs sh

