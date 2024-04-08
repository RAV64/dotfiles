function update_neovim_nightly
    curl -L -o ~/Downloads/nvim-macos.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
    xattr -c ~/Downloads/nvim-macos.tar.gz

    rm -rf ~/dotfiles/scripts/bin/nvim-macos
    tar xzvf ~/Downloads/nvim-macos.tar.gz -C ~/dotfiles/scripts/bin
end
