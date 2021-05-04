#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
WHITE="\[\e[0;37m\]"

BOLD="\[\e[01m\]"

RESET="\[\e[00m\]"

parse_git_branch() {
  line=$(git status 2> /dev/null | head -n1)
  branch=${line##* }
  if [[ $branch != "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working tree clean" ]]; then
      echo " ${GREEN}$branch${RESET}"
    else
      echo " ${RED}$branch${RESET}"
    fi
  fi
}

parse_remote_state() {
  remote_state=$(git status -sb 2> /dev/null | grep -oh "\[.*\]")
  if [[ "$remote_state" != "" ]]; then
    out="${CYAN}[${RESET}"
    if [[ "$remote_state" == *ahead* ]] && [[ "$remote_state" == *behind* ]]; then
      behind_num=$(echo "$remote_state" | grep -oh "behind [0-9]*" | grep -oh "[0-9]*$")
      ahead_num=$(echo "$remote_state" | grep -oh "ahead [0-9]*" | grep -oh "[0-9]*$")
      out="$out${RED}$behind_num${CYAN},${GREEN}$ahead_num${RESET}"
    elif [[ "$remote_state" == *ahead* ]]; then
      ahead_num=$(echo "$remote_state" | grep -oh "ahead [0-9]*" | grep -oh "[0-9]*$")
      out="$out${GREEN}$ahead_num${RESET}"
    elif [[ "$remote_state" == *behind* ]]; then
      behind_num=$(echo "$remote_state" | grep -oh "behind [0-9]*" | grep -oh "[0-9]*$")
      out="$out${RED}$behind_num${RESET}"
    fi
    out="$out${CYAN}]${RESET}"
    echo "$out"
  fi
}

prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="${GREEN}"
  else
    exit_status="${RED}"
  fi
  history -a
  history -n
  PS1="${CYAN}[\W$(parse_git_branch)${CYAN}]$(parse_remote_state)${RESET} ${exit_status}|>${RESET} "
}
PROMPT_COMMAND=prompt

# Replace default programs with better rust alternatives
# alias ls='ls --color=auto'
alias ls='exa'
alias cat='bat'
# alias grep='rg'
# alias find='fd'
# alias ps='procs'
