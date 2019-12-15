#export PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\W\[\033[m\]\$ "
# export PS1='\[\033[01;36m\]\u\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u : \[\033[01;34m\]\w\[\033[00m\] % '

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

alias cwd='cd /c/Users/liang/'
alias cdt='cd /c/Users/liang/Desktop; ls'
alias cws='cd /d/workspace/; ls'
alias cgh='cd /d/workspace/code/github/;ls'
alias wk='vi /d/workspace/code/github/xjliang.github.io/_wiki/'

# reload config
alias rvim='source ~/.vimrc'
alias rba='source ~/.bash_profile'


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

