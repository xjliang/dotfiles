#!/usr/bin/env bash

# TODO:
# - If there's a flag set, use SSH clone (low priority)
# - check that git dependency is set (low priority)
# - Ask for confirmation for each symlink
# - Ask for confirmation for installation location
# - Update existing repository, check whether the current folder
#   name is dotfiles

set -e

DIR="$(cd $(dirname "$0") && pwd)"

#echo $DIR
#exit 0

check_if_update() {
    parent_dir=$(basename $(pwd))
    if [[ $parent_dir == "dotfiles" ]]; then
        echo "It seems that you're updating; this script only handles installation."
        exit 1
    fi
}

check_denpencies() {
    type git &> /dev/null || echo -e "\[\033[1;31m\]git is a required dependency.\[\033[0m\]"
}

# check if we're updating or installing
check_if_update

# check dependencies are installed
check_denpencies

echo "This script will download and install the dotfiles from"
echo "https://github.com/eeux/dotfiles."
echo "if you want to update, please run this script from the dotfiles directory"
echo
echo "The dotfiles will be installed in "$(pwd)"/dotfiles"
read -p "Is that okay [Yn]? " confirm

# transfrom to lower case
confirm=$(echo $confirm | tr [:upper:] [:lower:])

if [[ -n $confim && $confirm != "y" && $confirm != "yes" ]]; then
    echo "Please re-run this script in the desired installation directory."
    exit 1
fi

echo -e "Downloading and installing..."
git clone --quiet https://github.com/eeux/dotfiles.git dotfiles
cd dotfiles

# Build up a list of all the dotfiles (ignoring .git and .gitignore)
dotfiles=$(find . -maxdepth 1 -name ".[^.]*" -exec basename {} \; | grep -vE ".git(ignore)?$")

echo
echo -e "Symlinking the following dotfiles:\n$dotfiles"
echo -e "[info] Existing files will be backed up with the .old extension\n"

DIR=$(pwd)
for f in ${dotfiles}; do
    local_f="$HOME/$f"
    abs_path="$DIR/$f"
    if [[ -f $local_f ]]; then
        echo "cp $local_f to $local_f.old"
        cp -f $local_f $local_f.old
    elif [[ -L $local_f && ! -d $local_f ]]; then
        echo "cp $local_f to $local_f.old"
        cp -f $local_f $local_f.old
    elif [[ -L $local_f && -d $local_f ]]; then
        echo "mv $local_f to $local_f.old"
        mv -f $local_f $local_f.old
    fi

    echo "link $abs_path -> $local_f"
    echo
    ln -sf $abs_path $local_f
done

# TODO: ask for plugin installation
echo "[info] if you want use a plugin-free vim, you can just rm ~/.vimrc.bundles"
#echo
#echo "Installing vim plugins (could take a while)"

source ~/.bashrc

echo
echo "Everything succesfully installed."
exit 0

