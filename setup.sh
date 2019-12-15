#!/bin/bash

CURDIR=$(pwd)

cd ~/
if [ -e ~/.vimrc ]; then
  mv -v ~/.vimrc ~/.vimrc.bak
fi

if [ -e ~/.tmux.conf ]; then
  mv -v ~/.tmux.conf ~/.tmux.conf.bak
fi

if [ -e ~/.bash_aliases ]; then
  mv -v ~/.bash_aliases ~/.bash_aliases.bak
fi

if [ -e ~/.gitconfig ]; then
  mv -v ~/.gitconfig ~/.gitconfig.bak
fi

ln -s $CURDIR/tmux.conf .tmux.conf
echo "linking ~/.tmux.conf -> $CURDIR/tmux.conf"

ln -s $CURDIR/bash_aliases .bash_aliases
echo "linking ~/.bash_aliases -> $CURDIR/bash_aliases"

ln -s $CURDIR/gitconfig .gitconfig
echo "linking ~/.gitconfig -> $CURDIR/gitconfig"

echo "set runtimepath+=${CURDIR}/vim" > ~/.vimrc
echo "source ${CURDIR}/vim/vimrc.vim" >> ~/.vimrc

echo "Done."

