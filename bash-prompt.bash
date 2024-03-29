export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

## ===============================================
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

PS1="\[$COLOR_WHITE\]\n[\W]"    # basename of pwd
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
export PS1
## export PS1="\[\033[36m\]\u:\[\033[34;1m\]\w\[\033[m\]\[\033[38;5;95m\]\$(git_branch) $ "
export PS1="\[$COLOR_WHITE\]\[\033[34;1m\]\w\[\033[m\]\[\033[$COLOR_YELLOW\]\$(git_branch)\[$COLOR_WHITE\] $ "

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  local no_branch="fatal: not a git repository(*)"
  
  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  elif [[ $git_status =~ $no_branch ]]; then
    local commit="\\"
    echo "($commit)"
  el
    echo "\\"
  fi
}
