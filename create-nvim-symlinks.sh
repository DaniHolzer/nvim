#!/usr/bin/env sh

#-----------------------------------------------------------------------------
#  Neovim Configs
#-----------------------------------------------------------------------------

# Delete ~/.config/nvim directory if it exists
# Delete ~/.config/nvim/:
rm -rf $HOME/.config/nvim

# Create a symlink named nvim from ~/.config to ~/personal/github/nvim
# If nvim starts it searches for configurations in ~/.config
# By creating this symlink, nvim runs with the configuration from ~/personal/github/nvim
# Create symlink to ~/personal/nvim/:
ln -s $HOME/personal/github/nvim $HOME/.config/nvim

