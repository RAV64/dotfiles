function turboupdate
    brew upgrade

    brew upgrade wezterm@nightly
    brew install --cask font-monaspace-nerd-font

    bob use nightly

    rustup update
    cargo install-update -a

    npm update -g

    bun upgrade
    bun-update

    tldr --update
end
