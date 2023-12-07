#! /bin/bash

ln -fs ~/dotfiles/nvim ~/.config
ln -fs ~/dotfiles/bat ~/.config
ln -fs ~/dotfiles/fish ~/.config
ln -fs ~/dotfiles/wezterm ~/.config
ln -f ~/dotfiles/starship.toml ~/.config/starship.toml

ln -f ~/dotfiles/.ignore ~/
ln -f ~/dotfiles/.gitconfig ~/

if [[ $(uname) == 'Darwin' ]]; then
    ln -fs ~/dotfiles/.hammerspoon ~/
    ln -fs ~/dotfiles/karabiner ~/.config
fi
