#! /bin/bash

ln -fs ~/dotfiles/nvim ~/.config
ln -fs ~/dotfiles/bat ~/.config
ln -fs ~/dotfiles/fish ~/.config
ln -fs ~/dotfiles/wezterm ~/.config
ln -f ~/dotfiles/starship.toml ~/.config/starship.toml

ln -fs ~/dotfiles/.ignore ~/.ignore
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig

if [[ $(uname) == 'Darwin' ]]; then
    ln -fs ~/dotfiles/.hammerspoon ~/
    ln -fs ~/dotfiles/karabiner ~/.config
fi
