function turboupdate
  brew upgrade
  rustup update
  cargo install-update -a
  brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
  npm update -g
  bun upgrade
  bun-update
  tldr --update
end
