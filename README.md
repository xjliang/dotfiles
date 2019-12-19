# Eeux's dotfiles

Configuration files for bash, vim, git and tmux.

## Installation

The installation script will automatically clone the git repository, symlink
the dotfiles to your home directory, and install the vim plugins.

```bash
$ bash < <(curl --silent https://raw.github.com/eeux/dotfiles/master/install.sh)
```

## Plugin for vim

The script doesn't install any plugin for vim.
Therefore, you need to link vim.bundles for your vim.

```bash
$ link -s <dotfiles localtion>/vimrc.bundles ~/.vimrc.bundles
```

Enjoy :)
