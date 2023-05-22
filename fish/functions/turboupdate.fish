function turboupdate
    brew upgrade
    brew update
    rustup update
    npm update -g
    cargo install-update -a
    # fisher update
    brew upgrade --cask wez/wezterm/wezterm-nightly --no-quarantine --greedy-latest
    brew uninstall neovim
    brew install neovim --fetch-HEAD
    bun upgrade
    bun-update
    tldr --update
end
