function turboupdate
    brew upgrade
    brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
    brew tap homebrew/cask-fonts
    brew install --cask font-monaspace-nerd-font

    update_neovim_nightly

    rustup update
    cargo install-update -a

    npm update -g

    bun upgrade
    bun-update

    tldr --update
end
