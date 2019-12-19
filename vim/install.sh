#!/bin/bash

set -e

# refer bootstrap.sh
BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=$(pwd)

# parse arguments
show_help()
{
    echo "install.sh [option]
    --for-vim       Install configuration files for vim, default option
    --with-ycm      Install YouCompleteMe
    --help          Show help messages
For example:
    install.sh --for-vim
    install.sh --help"
}

FOR_VIM=true
WITH_YCM=false
if [ "$1" != "" ]; then
    case $1 in
        --for-vim)
            FOR_VIM=true
            shift
            ;;
        --with-ycm)
            WITH_YCM=true
            shift
            ;;
        *)
            show_help
            exit
            ;;
    esac
fi

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}


echo "Step1: backing up current vim config"
today=$(date +%Y%m%d)
if $FOR_VIM; then
    #for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles; do
    #    [ -e $i ] && [ ! -L $i ] && mv $i $i.$today;
    #done
    #for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles; do
    #    [ -L $i ] && unlink $i ;
    #done
    for i in $HOME/.vimrc $HOME/.vimrc.bundles; do
        [ -e $i ] && [ ! -L $i ] && mv $i $i.$today;
    done
    for i in $HOME/.vimrc $HOME/.vimrc.bundles; do
        [ -L $i ] && unlink $i ;
    done
fi

echo "Step2: setting up symlinks"
if $FOR_VIM; then
    lnif $CURRENT_DIR/vimrc $HOME/.vimrc
    lnif $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
    lnif "$CURRENT_DIR/" "$HOME/.vim"
fi

echo "Step3: update/install plugins using Vim-plug"
system_shell=$SHELL
export SHELL="/bin/sh"
if $FOR_VIM; then
    vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
fi
export SHELL=$system_shell

if $WITH_YCM; then
    echo "Step4: compile YouCompleteMe"
    echo "It will take a long time, just be patient!"
    echo "If error,you need to compile it yourself"
    echo "cd $CURRENT_DIR/bundle/YouCompleteMe/ && python install.py --clang-completer"
    cd $CURRENT_DIR/bundle/YouCompleteMe/
    git submodule update --init --recursive
    if [ $(which clang) ]   # check system clang
    then
        python install.py --clang-completer --system-libclang   # use system clang
    else
        python install.py --clang-completer
    fi
fi

echo "Install Done!"

