#export PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\W\[\033[m\]\$ "
# export PS1='\[\033[01;36m\]\u\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '

#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u : \[\033[01;34m\]\w\[\033[00m\] % '
PS1='[\[\033[01;32m\]\u\[\033[00m\] \w$(__git_ps1 " \[\033[01;31m\](%s)\[\033[00m\]")] % '

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR='vim'

export PATH=/usr/local/bin:$PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval $(dircolors -b $HOME/.dircolors)

# ---------------------------------------
# Alias
# ---------------------------------------
alias ls='ls -GFh --color=auto'
alias ll='ls -larth'
alias grep='grep --color=auto'

alias vi='vim'
alias tm='tmux -2'
alias sr='source ~/.bashrc'

alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'

alias df='df -h'
alias rm='rm -vi'
alias mv='mv -v'
alias cp='cp -v'

# make related
alias make="make -j8"
alias maked="make -j8 DEBUG=1"
alias maket="make -j8 UNIT_TEST=1"

# quicker cd
alias ..='cd ..'
alias ...='cd ..; cd ..; ls'

# reload config
alias rvim='source ~/.vimrc'
alias reload='source ~/.bashrc'


# fzf lua required
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#eval "$(lua5.3 ~/github/z.lua/z.lua --init bash enhanced)"
#
#alias zc='z -c'      # match exactly
#alias zz='z -i'      # interractive mode
#alias zf='cd "$(z -l -s | fzf --reverse --height 35%)"'
#alias vf='vim $(fzf)'

# git related
alias ga='git add'
alias gcm='git commit -m'
alias gs='git status'
alias gcl='git clone'
alias gp='git push'

#source ~/.git-prompt.sh


# Create a directory and cd into it
mcd() {
    mkdir "${1}" && cd "${1}"
}

# Go up [n] directories
up()
{
    local cdir="$(pwd)"
    if [[ "${1}" == "" ]]; then
        cdir="$(dirname "${cdir}")"
    elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a number"
    elif ! [[ "${1}" -gt "0" ]]; then
        echo "Error: argument must be positive"
    else
        for ((i=0; i<${1}; i++)); do
            local ncdir="$(dirname "${cdir}")"
            if [[ "${cdir}" == "${ncdir}" ]]; then
                break
            else
                cdir="${ncdir}"
            fi
        done
    fi
    cd "${cdir}"
}

function gcat() {
    git cat-file -p $1
}


### 1337 PS1 PROMPT ###
COLOR_CYAN="\[\033[0;36m\]"
COLOR_RED="\[\033[0;31m\]"
COLOR_YELLOW="\[\033[0;33m\]"
COLOR_GREEN="\[\033[0;32m\]"
COLOR_OCHRE="\[\033[38;5;95m\]"
COLOR_BLUE="\[\033[0;94m\]"
COLOR_WHITE="\[\033[0;37m\]"
COLOR_RESET="\[\033[0m\]"

function git_status_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working tree clean" ]]; then
    echo $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo $COLOR_BLUE
  elif [[ $git_status =~ "Your branch is behind" ]] || [[ $git_status =~ "different commits each" ]]; then
    echo $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo $COLOR_GREEN
  else
    echo $COLOR_OCHRE
  fi
}

function colored_git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$COLOR_GREEN($(git_status_color)$branch$COLOR_GREEN) "
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$COLOR_GREEN($(git_status_color)$commit$COLOR_GREEN) "
  fi
}

function set_bash_prompt {
  PS1="\n"
  # timestamp
  #PS1+="$COLOR_GREEN|$COLOR_BLUE\t$COLOR_GREEN|"
  # user
  PS1+="$COLOR_BLUE\u "
  # path
  PS1+="$COLOR_CYAN\w "
  #PS1+="\n"
  # git branch/status
  PS1+="$(colored_git_branch)"
  PS1+="%$COLOR_RESET "

}

#PROMPT_COMMAND=set_bash_prompt
