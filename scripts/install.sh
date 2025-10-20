if ! command -v fish >/dev/null 2>&1; then
	sudo zypper --non-interactive install fish
	chsh -s $(which fish)
fi

if ! command -v make >/dev/null 2>&1; then
	sudo zypper --non-interactive install cmake make
fi

if ! command -v cc >/dev/null 2>&1; then
	sudo zypper --non-interactive install gcc
fi

if ! command -v rustc >/dev/null 2>&1; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup component add rust-analyzer
	cargo install ripgrep fd-find bat starship zoxide exa difftastic
fi

if ! command -v fzf >/dev/null 2>&1; then
	sudo zypper --non-interactive install fzf
fi

if ! command -v nvim >/dev/null 2>&1; then
	sudo zypper --non-interactive install neovim
fi

